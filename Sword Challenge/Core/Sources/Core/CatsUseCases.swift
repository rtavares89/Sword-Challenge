
import Foundation

public protocol CatsUseCases {
    var cats: [Cat] { get }
    func fetchCats(page: Int) async throws -> [Cat]
    func getFavouriteCats() throws -> [Cat]
    func getCat(id: String) -> Cat?
    func search(catBreed: String) async throws -> [Cat]
    func setFavourite(id: String) -> Cat?
    func favouritesAverageLifespan() -> Int
}

public final class CatsUseCasesImplementation: CatsUseCases {

    private let catsGateway: CatsGateway
    private let favouriteCatsRepository: FavouriteCatsRepository
    public var cats = [Cat]()

    public init(catsGateway: CatsGateway, favouriteCatsRepository: FavouriteCatsRepository) {
        self.catsGateway = catsGateway
        self.favouriteCatsRepository = favouriteCatsRepository
    }

    public func fetchCats(page: Int) async throws -> [Cat] {
        let catBreeds = try await catsGateway.fetchCatBreeds(page: page)
        let catImages = try await fetchCatImages(imagesIds: catBreeds.compactMap { $0.imageId })
        let favouriteCats = try getFavouriteCats()

        cats = mergeCatBreedWithImage(catBreeds: catBreeds, catImages: catImages, favouriteCats: favouriteCats)

        return cats
    }

    public func getFavouriteCats() throws -> [Cat] {
        try favouriteCatsRepository.findAll()
    }

    public func getCat(id: String) -> Cat? {
        cats.first { $0.breed.id == id }
    }

    public func search(catBreed: String) async throws -> [Cat] {
        let catBreeds = try await catsGateway.search(catBreed: catBreed)
        let catImages = try await fetchCatImages(imagesIds: catBreeds.compactMap { $0.imageId })
        let favouriteCats = try getFavouriteCats()

        cats = mergeCatBreedWithImage(catBreeds: catBreeds, catImages: catImages, favouriteCats: favouriteCats)

        return cats
    }

    public func setFavourite(id: String) -> Cat? {
        guard let catIndex = cats.firstIndex(where: { cat in
            cat.breed.id == id
        }) else { return nil }

        cats[catIndex].isFavourite.toggle()

        if cats[catIndex].isFavourite {
            favouriteCatsRepository.insert(cats[catIndex])
        } else {
            try? favouriteCatsRepository.delete(cats[catIndex].breed.id)
        }

        return cats[catIndex]
    }

    public func favouritesAverageLifespan() -> Int {

        guard let favouriteCats = try? getFavouriteCats() else { return 0 }

        guard !favouriteCats.isEmpty else { return 0 }

        let lowerBoundLifespan = favouriteCats.compactMap { cat in
            cat.breed.lifeSpan
                .components(separatedBy: .decimalDigits.inverted)
                .filter { $0 != "" }
                .compactMap { Int($0) }
                .first
        }

        guard lowerBoundLifespan.count != 0 else { return 0 }

        return lowerBoundLifespan.reduce(0, +) / lowerBoundLifespan.count
    }

    private func fetchCatImages(imagesIds: [String]) async throws -> [CatImage] {

        let catImages = try await withThrowingTaskGroup(of: CatImage.self, returning: [CatImage].self) { group in

            imagesIds.forEach { id in
                group.addTask {
                    let imageUrl = try await self.catsGateway.fetchCatImage(imageId: id)

                    let image = try await self.catsGateway.downloadCatImage(url: imageUrl.url)

                    return CatImage(id: imageUrl.id, url: imageUrl.url, data: image)
                }
            }

            var catImagesResult = [CatImage]()

            for try await catImage in group {
                catImagesResult.append(catImage)
            }

            return catImagesResult
        }

        return catImages
    }

    private func mergeCatBreedWithImage(catBreeds: [CatBreed], catImages: [CatImage], favouriteCats: [Cat]) -> [Cat] {
        cats = catBreeds.map { breed in
            let image = catImages.first { image in
                image.id == breed.imageId
            }

            let favouriteCat = favouriteCats.first { favouriteCat in
                favouriteCat.breed.id == breed.id
            }

            return Cat(breed: breed, image: image, isFavourite: favouriteCat?.isFavourite ?? false)
        }

        return cats
    }
}


import Foundation

public protocol CatsUseCases {
    var cats: [Cat] { get }
    func fetchCats(page: Int) async throws -> [Cat]
    func getFavouriteCats() -> [Cat]
    func getCat(id: String) -> Cat?
    func search(catBreed: String) async throws -> [Cat]
    func setFavourite(id: String) -> Cat?
}

public final class CatsUseCasesImplementation: CatsUseCases {

    private let catsGateway: CatsGateway
    public var cats = [Cat]()

    public init(catsGateway: CatsGateway) {
        self.catsGateway = catsGateway
    }

    public func fetchCats(page: Int) async throws -> [Cat] {
        let catBreeds = try await catsGateway.fetchCatBreeds(page: page)
        let catImages = try await fetchCatImages(imagesIds: catBreeds.map { $0.imageId })

        cats = mergeCatBreedWithImage(catBreeds: catBreeds, catImages: catImages)

        return cats
    }

    public func getFavouriteCats() -> [Cat] {
        cats.filter { $0.isFavourite == true }
    }

    public func getCat(id: String) -> Cat? {
        cats.first { $0.breed.id == id }
    }

    public func search(catBreed: String) async throws -> [Cat] {
        let catBreeds = try await catsGateway.search(catBreed: catBreed)
        let catImages = try await fetchCatImages(imagesIds: catBreeds.map { $0.imageId })

        cats = mergeCatBreedWithImage(catBreeds: catBreeds, catImages: catImages)

        return cats
    }

    public func setFavourite(id: String) -> Cat? {
        guard let catIndex = cats.firstIndex(where: { cat in
            cat.breed.id == id
        }) else { return nil }

        cats[catIndex].isFavourite.toggle()

        return cats[catIndex]
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

    private func mergeCatBreedWithImage(catBreeds: [CatBreed], catImages: [CatImage]) -> [Cat] {
        cats = catBreeds.map { breed in
            let image = catImages.first { image in
                image.id == breed.imageId
            }

            return Cat(breed: breed, image: image)
        }

        return cats
    }
}

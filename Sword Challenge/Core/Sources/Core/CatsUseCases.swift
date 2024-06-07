//
//  File.swift
//  
//
//  Created by Ricardo Tavares on 06/06/2024.
//

import Foundation

public protocol CatsUseCases {
    func fetchCats(page: Int) async throws -> [Cat]
}

public final class CatsUseCasesImplementation: CatsUseCases {

    private let catsGateway: CatsGateway

    public init(catsGateway: CatsGateway) {
        self.catsGateway = catsGateway
    }

    public func fetchCats(page: Int) async throws -> [Cat] {
        let catBreeds = try await catsGateway.fetchCatBreeds(page: page)
        let catImages = try await fetchCatImages(imagesIds: catBreeds.map { $0.imageId })

        let cats = catBreeds.map { breed in
            let image = catImages.first { image in
                image.id == breed.imageId
            }

            return Cat(breed: breed, image: image)
        }

        return cats
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
}

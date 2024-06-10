
import Foundation
@testable import Core

struct CatsGatewayError: Error { }

final class CatsGatewayStub: CatsGateway {

    var fetchCatBreedsCalled = false
    var fetchCatImageCalled = false
    var downloadCatImageCalled = false
    var searchCatBreedsCalled = false

    var fetchCatBreedShouldThrow = false
    var fetchCatImageShouldThrow = false
    var downloadCatImageShouldThrow = false
    var searchCatBreedShouldThrow = false

    var catBreeds = [CatBreed]()
    var catImage = [String: CatImage]()
    var imageData = Data()

    func fetchCatBreeds(page: Int) async throws -> [CatBreed] {
        fetchCatBreedsCalled = true

        if fetchCatBreedShouldThrow {
            throw CatsGatewayError()
        }

        return catBreeds
    }
    
    func fetchCatImage(imageId: String) async throws -> CatImage {
        fetchCatImageCalled = true

        if fetchCatImageShouldThrow {
            throw CatsGatewayError()
        }

        return catImage[imageId]!
    }
    
    func downloadCatImage(url: String) async throws -> Data? {
        downloadCatImageCalled = true

        if downloadCatImageShouldThrow {
            throw CatsGatewayError()
        }

        return imageData
    }

    func search(catBreed: String) async throws -> [CatBreed] {
        searchCatBreedsCalled = true

        if searchCatBreedShouldThrow {
            throw CatsGatewayError()
        }

        return catBreeds
    }
}


import Foundation

public protocol CatsGateway {
    func fetchCatBreeds(page: Int) async throws -> [CatBreed]
    func fetchCatImage(imageId: String) async throws -> CatImage
    func downloadCatImage(url: String) async throws -> Data?
    func search(catBreed: String) async throws -> [CatBreed]
}


import Foundation

public protocol CatsGateway {
    func fetchCatBreeds(page: Int) async throws -> [CatBreed] 
}


import Foundation

public protocol CatsGateway {
    func fetchCats(page: Int) async throws -> [CatBreed] 
}

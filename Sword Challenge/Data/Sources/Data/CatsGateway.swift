
import Foundation
import Core

final class CatsGatewayImplementation: CatsGateway {
    
    private let apiKey = "live_qscBcf738qWxM8kl1MJQfzj9J4sGHlMMk9A3Wge2CS2GixhLg5KNzTANlw1eLFum"
    private let jsonDecoder: JSONDecoder

    init(jsonDecoder: JSONDecoder) {
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        self.jsonDecoder = jsonDecoder
    }

    func fetchCats(page: Int) async throws -> [CatBreed] {

        guard let url = URL(string: "https://api.thecatapi.com/v1/breeds?limit=10&page=\(page)") else { return [] }

        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))

        let catsResponse = try jsonDecoder.decode([CatBreedResponse].self, from: data)

        let catsBreed = catsResponse.compactMap { CatBreed(catResponse: $0) }

        return catsBreed
    }
}

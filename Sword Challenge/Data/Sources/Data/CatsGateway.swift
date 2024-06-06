
import Foundation
import Core

public final class CatsGatewayImplementation: CatsGateway {

    // TODO: Remove apiKey
//    private let apiKey = "live_qscBcf738qWxM8kl1MJQfzj9J4sGHlMMk9A3Wge2CS2GixhLg5KNzTANlw1eLFum"
    private let jsonDecoder: JSONDecoder

    public init(jsonDecoder: JSONDecoder) {
        self.jsonDecoder = jsonDecoder
    }

    public func fetchCatBreeds(page: Int) async throws -> [CatBreed] {

        guard let url = URL(string: "https://api.thecatapi.com/v1/breeds?limit=10&page=\(page)") else { return [] }

        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))

        let catsResponse = try jsonDecoder.decode([CatBreedResponse].self, from: data)

        let catsBreed = catsResponse.map { CatBreed(catBreedResponse: $0) }

        return catsBreed
    }

    public func fetchCatImage(imageId: String) async throws -> CatImage? {

        guard let url = URL(string: "https://api.thecatapi.com/v1/images/\(imageId)") else { return nil }

        let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))

        let catImageResponse = try jsonDecoder.decode(CatImageResponse.self, from: data)

        let catImage = CatImage(catImageResponse: catImageResponse)

        return catImage
    }

    public func downloadCatImage(url: String) async throws -> Data? {

        guard let url = URL(string: url) else { return nil }

        let (data, _) = try await URLSession.shared.data(from: url)

        return data
    }
}


import Foundation
import Core

public final class CatsGatewayImplementation: CatsGateway {

    private let apiClient: ApiClient
    private let baseUrl: URL

    public init(apiClient: ApiClient, baseUrl: URL) {
        self.apiClient = apiClient
        self.baseUrl = baseUrl
    }

    public func fetchCatBreeds(page: Int) async throws -> [CatBreed] {

        let request = CatBreedsRequest(baseUrl: baseUrl, page: page).request

        let catBreedsResponse: [CatBreedsResponse] = try await apiClient.getArray(request: request)

        let catsBreed = catBreedsResponse.map { CatBreed(catBreedResponse: $0) }

        return catsBreed
    }

    public func fetchCatImage(imageId: String) async throws -> CatImage {

        let request = CatImageRequest(baseUrl: baseUrl, imageId: imageId).request

        let catImageResponse: CatImageResponse = try await apiClient.get(request: request)

        let catImage = CatImage(catImageResponse: catImageResponse)

        return catImage
    }

    public func downloadCatImage(url: String) async throws -> Data? {

        guard let url = URL(string: url) else { return nil }

        let data = try await apiClient.download(request: URLRequest(url: url))

        return data
    }

    public func search(catBreed: String) async throws -> [CatBreed] {

        let request = SearchCatBreedRequest(baseUrl: baseUrl, searchBreed: catBreed).request

        let catBreedsResponse: [CatBreedsResponse] = try await apiClient.getArray(request: request)

        let catBreeds = catBreedsResponse.map { CatBreed(catBreedResponse: $0) }

        return catBreeds
    }
}

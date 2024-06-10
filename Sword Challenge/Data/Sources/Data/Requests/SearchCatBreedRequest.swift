
import Foundation

struct SearchCatBreedRequest {
    
    private let url: URL!

    var request: URLRequest {
        return URLRequest(url: url)
    }

    init(baseUrl: URL, searchBreed: String) {
        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false)!
        components.path = "/v1/breeds/search"
        components.queryItems = [
            URLQueryItem(name: "q", value: "\(searchBreed)")
        ]

        self.url = components.url
    }
}

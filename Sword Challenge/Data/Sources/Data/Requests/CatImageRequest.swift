
import Foundation

struct CatImageRequest {

    private let url: URL!

    var request: URLRequest {
        return URLRequest(url: url)
    }

    init(baseUrl: URL, imageId: String) {
        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false)!
        components.path = "/v1/images/\(imageId)"

        self.url = components.url
    }
}

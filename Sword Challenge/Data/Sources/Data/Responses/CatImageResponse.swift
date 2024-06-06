
import Foundation
import Core

struct CatImageResponse: Decodable {
    var id: String
    var url: String
}

extension CatImage {

    init(catImageResponse: CatImageResponse) {
        self.init(id: catImageResponse.id,
                  url: catImageResponse.url)
    }
}

#if DEBUG

extension CatImageResponse {
    static let mock = CatImageResponse(id: "an-image-id",
                                       url: "http://an-url.com/12345")
}

#endif


import XCTest
@testable import Data

final class CatImageRequestTests: XCTestCase {

    func test_GIVEN_a_baseUrl_and_page_WHEN_creating_catImageRequest_THEN_should_have_the_correctly_formed() {

        let baseUrl = URL(string: "https://a-base-url.com/")!
        let imageId = "image-id"

        let request = CatImageRequest(baseUrl: baseUrl, imageId: imageId)

        XCTAssertEqual(request.request.url?.absoluteString, "https://a-base-url.com/v1/images/image-id")
        XCTAssertEqual(request.request.httpMethod, "GET")
    }
}


import XCTest
@testable import Data

final class CatBreedsRequestTests: XCTestCase {

    func test_GIVEN_a_baseUrl_and_page_WHEN_creating_catBreedsRequest_THEN_should_have_the_correctly_formed() {

        let baseUrl = URL(string: "https://a-base-url.com/")!
        let page = 0

        let request = CatBreedsRequest(baseUrl: baseUrl, page: page)

        XCTAssertEqual(request.request.url?.absoluteString, "https://a-base-url.com/v1/breeds?page=0&limit=10")
        XCTAssertEqual(request.request.httpMethod, "GET")
    }
}

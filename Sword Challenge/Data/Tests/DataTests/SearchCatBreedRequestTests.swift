
import XCTest
@testable import Data

final class SearchCatBreedRequestTests: XCTestCase {

    func test_GIVEN_a_baseUrl_and_query_WHEN_creating_catImageRequest_THEN_should_have_the_correctly_formed() {

        let baseUrl = URL(string: "https://a-base-url.com/")!
        let query = "breed"

        let request = SearchCatBreedRequest(baseUrl: baseUrl, searchBreed: query)

        XCTAssertEqual(request.request.url?.absoluteString, "https://a-base-url.com/v1/breeds/search?q=breed")
        XCTAssertEqual(request.request.httpMethod, "GET")
    }
}

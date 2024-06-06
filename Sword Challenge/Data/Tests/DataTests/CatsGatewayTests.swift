
import XCTest
import Core
@testable import Data

final class CatsGatewayTests: XCTestCase {

    private var gateway: CatsGatewayImplementation!
    private var apiClientStub: ApiClientStub!

    override func setUp() {
        super.setUp()

        let baseUrl = URL(string: "https://a-base-url.com/")!
        apiClientStub = ApiClientStub()
        gateway = CatsGatewayImplementation(apiClient: apiClientStub, baseUrl: baseUrl)
    }

    override func tearDown() {
        super.tearDown()

        apiClientStub = nil
        gateway = nil
    }

    func test_GIVEN_a_page_WHEN_fetching_cat_breeds_THEN_should_call_apiClient_getArray() async throws {
        apiClientStub.returnArrayObject = [CatBreedsResponse.mock]

        let _ = try await gateway.fetchCatBreeds(page: 0)

        XCTAssertEqual(apiClientStub.getArrayCalled, true)
    }

    func test_GIVEN_a_page_WHEN_fetching_cat_breeds_And_apiClient_succeeds_THEN_should_return_catBreeds_objects() async throws {
        apiClientStub.returnArrayObject = [CatBreedsResponse.mock]

        let response = try await gateway.fetchCatBreeds(page: 0)

        XCTAssertEqual(response, [CatBreed(catBreedResponse: CatBreedsResponse.mock)])
    }

    func test_GIVEN_a_page_WHEN_fetching_cat_breeds_And_apiClient_throws_expection_THEN_should_throw_expection() async throws {
        apiClientStub.shouldThrow = true

        do {
            let _ = try await gateway.fetchCatBreeds(page: 0)
        } catch {
            XCTAssertNotNil(error)
            return
        }

        XCTFail("Should throw error")
    }

    func test_GIVEN_an_imageId_WHEN_fetching_cat_image_THEN_should_call_apiClient_get() async throws {
        let imageId = "an-image-id"
        apiClientStub.returnObject = CatImageResponse.mock

        let _ = try await gateway.fetchCatImage(imageId: imageId)

        XCTAssertEqual(apiClientStub.getCalled, true)
    }

    func test_GIVEN_an_imageId_WHEN_fetching_cat_image_And_apiClient_succeeds_THEN_should_return_catImage_object() async throws {
        let imageId = "an-image-id"
        apiClientStub.returnObject = CatImageResponse.mock

        let response = try await gateway.fetchCatImage(imageId: imageId)!

        XCTAssertEqual(response, CatImage(catImageResponse: CatImageResponse.mock))
    }

    func test_GIVEN_an_imageId_WHEN_fetching_cat_image_And_apiClient_throws_exception_THEN_should_throw_exception() async throws {
        let imageId = "an-image-id"
        apiClientStub.shouldThrow = true

        do {
            let _ = try await gateway.fetchCatImage(imageId: imageId)
        } catch {
            XCTAssertNotNil(error)
            return
        }

        XCTFail("Should throw error")
    }

    func test_GIVEN_an_image_url_WHEN_downloading_cat_image_THEN_should_call_apiClient_get() async throws {
        let imageUrl = "https://an-image-url.com"

        let _ = try await gateway.downloadCatImage(url: imageUrl)

        XCTAssertEqual(apiClientStub.downloadCalled, true)
    }

    func test_GIVEN_an_image_url_WHEN_downloading_cat_image_And_apiClient_succeeds_THEN_should_return_data_object() async throws {
        let imageUrl = "https://an-image-url.com"
        let data = Data(count: 2)
        apiClientStub.returnData = data

        let response = try await gateway.downloadCatImage(url: imageUrl)

        XCTAssertEqual(response, data)
    }

    func test_GIVEN_an_image_url_WHEN_downloading_cat_image_And_apiClient_throws_exception_THEN_should_throw_exception() async throws {
        let imageUrl = "https://an-image-url.com"
        apiClientStub.shouldThrow = true

        do {
            let _ = try await gateway.downloadCatImage(url: imageUrl)
        } catch {
            XCTAssertNotNil(error)
            return
        }

        XCTFail("Should throw error")
    }
}

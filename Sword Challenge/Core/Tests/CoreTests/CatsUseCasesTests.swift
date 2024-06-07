
import XCTest
@testable import Core

final class CatsUseCasesTests: XCTestCase {

    private var useCases: CatsUseCases!
    private var catGatewayStub: CatsGatewayStub!

    override func setUp() {
        super.setUp()

        catGatewayStub = CatsGatewayStub()
        useCases = CatsUseCasesImplementation(catsGateway: catGatewayStub)
    }

    override func tearDown() {
        super.tearDown()

        catGatewayStub = nil
        useCases = nil
    }

    func test_GIVEN_a_page_WHEN_fetchCats_called_THEN_should_call_fetchCatBreeds() async throws {
        let page = 0

        let _ = try await useCases.fetchCats(page: page)

        XCTAssertEqual(catGatewayStub.fetchCatBreedsCalled, true)
    }

    func test_GIVEN_a_page_WHEN_fetchCats_called_THEN_should_call_fetchCatImage() async throws {
        let page = 0
        catGatewayStub.catBreeds = [CatBreed.dummy]
        catGatewayStub.catImage = [CatImage.dummyWithData.id: CatImage.dummyWithData]

        let _ = try await useCases.fetchCats(page: page)

        XCTAssertEqual(catGatewayStub.fetchCatImageCalled, true)
    }

    func test_GIVEN_a_page_WHEN_fetchCats_called_THEN_should_call_downloadCatImage() async throws {
        let page = 0
        catGatewayStub.catBreeds = [CatBreed.dummy]
        catGatewayStub.catImage = [CatImage.dummyWithData.id: CatImage.dummyWithData]

        let _ = try await useCases.fetchCats(page: page)

        XCTAssertEqual(catGatewayStub.downloadCatImageCalled, true)
    }

    func test_GIVEN_a_page_WHEN_fetchCats_called_THEN_should_return_cat() async throws {
        let page = 0
        catGatewayStub.catBreeds = [CatBreed.dummy]
        catGatewayStub.catImage =  [CatImage.dummyWithData.id: CatImage.dummyWithData]

        let cat = try await useCases.fetchCats(page: page)

        XCTAssertEqual(cat, [Cat(breed: CatBreed.dummy, image: CatImage.dummyWithData)])
    }

    func test_GIVEN_a_page_WHEN_fetchCats_called_And_multiple_cat_breeds_are_fetched_THEN_should_return_cat_with_its_image() async throws {
        let page = 0
        catGatewayStub.catBreeds = [CatBreed.dummy2, CatBreed.dummy]
        catGatewayStub.catImage = [CatImage.dummyWithData.id: CatImage.dummyWithData, CatImage.dummyWithData2.id: CatImage.dummyWithData2]
        let expectedCats = [
            Cat(breed: CatBreed.dummy2, image: CatImage.dummyWithData2),
            Cat(breed: CatBreed.dummy, image: CatImage.dummyWithData)
        ]

        let cat = try await useCases.fetchCats(page: page)

        XCTAssertEqual(cat, expectedCats)
    }

    func test_GIVEN_a_cat_id_WHEN_getting_cat_by_id_THEN_should_return_cat() async throws {
        catGatewayStub.catBreeds = [CatBreed.dummy]
        catGatewayStub.catImage = [CatImage.dummyWithData.id: CatImage.dummyWithData]

        let _ = try await useCases.fetchCats(page: 0)

        let cat = useCases.getCat(id: CatBreed.dummy.id)

        XCTAssertEqual(cat, Cat(breed: CatBreed.dummy, image: CatImage.dummyWithData))
    }
}

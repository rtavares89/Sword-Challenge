
import XCTest
@testable import Core

final class CatsUseCasesTests: XCTestCase {

    private var useCases: CatsUseCasesImplementation!
    private var catGatewayStub: CatsGatewayStub!
    private var favouriteCatsRepository: FavouriteCatsRepositoryStub!

    override func setUp() {
        super.setUp()

        favouriteCatsRepository = FavouriteCatsRepositoryStub()
        catGatewayStub = CatsGatewayStub()
        useCases = CatsUseCasesImplementation(catsGateway: catGatewayStub, favouriteCatsRepository: favouriteCatsRepository)
    }

    override func tearDown() {
        super.tearDown()

        favouriteCatsRepository = nil
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

        XCTAssertEqual(cat, [Cat(breed: CatBreed.dummy, image: CatImage.dummyWithData, isFavourite: false)])
    }

    func test_GIVEN_a_page_WHEN_fetchCats_called_And_multiple_cat_breeds_are_fetched_THEN_should_return_cat_with_its_image() async throws {
        let page = 0
        catGatewayStub.catBreeds = [CatBreed.dummy2, CatBreed.dummy]
        catGatewayStub.catImage = [CatImage.dummyWithData.id: CatImage.dummyWithData, CatImage.dummyWithData2.id: CatImage.dummyWithData2]
        let expectedCats = [
            Cat(breed: CatBreed.dummy2, image: CatImage.dummyWithData2, isFavourite: false),
            Cat(breed: CatBreed.dummy, image: CatImage.dummyWithData, isFavourite: false)
        ]

        let cat = try await useCases.fetchCats(page: page)

        XCTAssertEqual(cat, expectedCats)
    }

    func test_GIVEN_a_cat_id_WHEN_getting_cat_by_id_THEN_should_return_cat() async throws {
        catGatewayStub.catBreeds = [CatBreed.dummy]
        catGatewayStub.catImage = [CatImage.dummyWithData.id: CatImage.dummyWithData]

        let _ = try await useCases.fetchCats(page: 0)

        let cat = useCases.getCat(id: CatBreed.dummy.id)

        XCTAssertEqual(cat, Cat(breed: CatBreed.dummy, image: CatImage.dummyWithData, isFavourite: false))
    }

    func test_GIVEN_a_cat_breed_query_WHEN_search_called_THEN_should_call_searchCatBreeds() async throws {
        catGatewayStub.catBreeds = [CatBreed.dummy]
        catGatewayStub.catImage = [CatImage.dummyWithData.id: CatImage.dummyWithData]
        let query = "Cat"

        let _ = try await useCases.search(catBreed: query)

        XCTAssertEqual(catGatewayStub.searchCatBreedsCalled, true)
    }

    func test_GIVEN_a_cat_breed_query_WHEN_search_called_THEN_should_return_cats() async throws {
        catGatewayStub.catBreeds = [CatBreed.dummy]
        catGatewayStub.catImage = [CatImage.dummyWithData.id: CatImage.dummyWithData]
        let query = "Cat"

        let cats = try await useCases.search(catBreed: query)

        XCTAssertEqual(cats, [Cat(breed: CatBreed.dummy, image: CatImage.dummyWithData, isFavourite: false)])
    }

    func test_GIVEN_a_cat_id_WHEN_getting_the_cat_THEN_should_return_cat() {
        let expectedCat = [Cat(breed: CatBreed.dummy, image: nil, isFavourite: false)]
        useCases.cats = expectedCat

        let cat = useCases.getCat(id: CatBreed.dummy.id)

        XCTAssertEqual(cat, expectedCat.first)
    }

    func test_WHEN_getting_favourite_cats_THEN_should_return_all_favourite_cats() {

        let expectedFavouriteCats = [
            Cat(breed: CatBreed.dummy, image: nil, isFavourite: true),
            Cat(breed: CatBreed.dummy2, image: nil, isFavourite: true)
        ]

        useCases.cats = [Cat(breed: CatBreed.dummy, image: nil, isFavourite: false)] + expectedFavouriteCats

        let favouriteCats = useCases.getFavouriteCats()

        XCTAssertEqual(favouriteCats, expectedFavouriteCats)
    }

    func test_GIVEN_a_cat_id_WHEN_setting_as_favourite_THEN_should_return_cat_as_favourite() {

        useCases.cats = [Cat(breed: CatBreed.dummy, image: nil, isFavourite: false)]

        let favouriteCat = useCases.setFavourite(id: CatBreed.dummy.id)

        XCTAssertEqual(favouriteCat, Cat(breed: CatBreed.dummy, image: nil, isFavourite: true))
    }

    func test_GIVEN_a_cat_id_WHEN_setting_as_favourite_THEN_should_set_cat_as_favourite() {

        useCases.cats = [Cat(breed: CatBreed.dummy, image: nil, isFavourite: false)]

        let _ = useCases.setFavourite(id: CatBreed.dummy.id)

        XCTAssertEqual(useCases.cats, [Cat(breed: CatBreed.dummy, image: nil, isFavourite: true)])
    }

    func test_GIVEN_favourite_cats_WHEN_calculating_favouritesAverageLifespan_THEN_should_return_average_lower_bound_lifespan() {
        useCases.cats = [Cat(breed: CatBreed.dummy, image: nil, isFavourite: true)]

        let lifespan = useCases.favouritesAverageLifespan()

        XCTAssertEqual(lifespan, 8)
    }
}

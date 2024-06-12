
import XCTest
import Core
@testable import Sword_Challenge

final class CatDetailsViewModelTests: XCTestCase {

    private var viewModel: CatDetailsViewModel!
    private var useCases: CatsUseCasesStub!

    @MainActor
    override func setUp() {
        super.setUp()

        useCases = CatsUseCasesStub()
        viewModel = CatDetailsViewModel(catsUseCases: useCases)
    }

    override func tearDown() {
        super.tearDown()

        useCases = nil
        viewModel = nil
    }

    @MainActor
    func test_GIVEN_a_cat_id_WHEN_viewAppear_is_called_THEN_should_call_getCat() {
        let catId = "a-cat-id"

        viewModel.viewAppear(catId: catId)

        XCTAssertEqual(useCases.getCatCalled, true)
    }

    @MainActor
    func test_GIVEN_a_cat_id_WHEN_viewAppear_is_called_THEN_should_return_cat() {
        let catId = "a-cat-id"
        let expectedCat = Cat.dummyWithImage
        useCases.cat = expectedCat

        viewModel.viewAppear(catId: catId)

        XCTAssertEqual(viewModel.cat, expectedCat)
    }

    @MainActor
    func test_WHEN_favouriteButtonTapped_is_called_THEN_should_call_setFavouriteCat() {
        viewModel.cat = Cat.dummyWithImage
        
        viewModel.favoriteButtonTapped()

        XCTAssertEqual(useCases.setFavouriteCalled, true)
    }

    @MainActor
    func test_GIVEN_a_favourite_cat_WHEN_checking_if_is_favourite_THEN_should_be_favourite_cat() {
        viewModel.cat = Cat.dummyWithImage

        XCTAssertEqual(viewModel.isFavourite, true)
    }

    @MainActor
    func test_GIVEN_a_not_favourite_cat_WHEN_checking_if_is_favourite_THEN_should_not_be_favourite_cat() {
        viewModel.cat = Cat.dummyWithImageNotFavourite

        XCTAssertEqual(viewModel.isFavourite, false)
    }

    @MainActor
    func test_GIVEN_a_favourite_cat_WHEN_checking_favourite_image_THEN_should_be_favourite() {
        viewModel.cat = Cat.dummyWithImage

        XCTAssertEqual(viewModel.favouriteImage, "star.fill")
    }

    @MainActor
    func test_GIVEN_a_not_favourite_cat_WHEN_checking_favourite_image_THEN_should_not_be_favourite() {
        viewModel.cat = Cat.dummyWithImageNotFavourite

        XCTAssertEqual(viewModel.favouriteImage, "star")
    }
}

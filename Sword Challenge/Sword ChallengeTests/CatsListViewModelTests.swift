
import XCTest
import Core
@testable import Sword_Challenge

final class CatsListViewModelTests: XCTestCase {

    private var viewModel: CatsListViewModel!
    private var useCases: CatsUseCasesStub!

    @MainActor
    override func setUp() {
        super.setUp()

        useCases = CatsUseCasesStub()
        viewModel = CatsListViewModel(catsUseCases: useCases)
    }

    override func tearDown() {
        super.tearDown()

        useCases = nil
        viewModel = nil
    }

    @MainActor
    func test_GIVEN_cats_is_empty_WHEN_viewAppear_is_called_THEN_should_fetch_cats() async {
        viewModel.cats = []

        await viewModel.viewAppear()

        XCTAssertEqual(useCases.fetchCatsCalled, true)
    }

    @MainActor
    func test_GIVEN_cats_is_not_empty_WHEN_viewAppear_is_called_THEN_should_not_fetch_cats() async {
        viewModel.cats = [CatListItem.dummy]

        await viewModel.viewAppear()

        XCTAssertEqual(useCases.fetchCatsCalled, false)
    }

    @MainActor
    func test_GIVEN_cats_is_empty_WHEN_viewAppear_is_called_THEN_return_fetch_CatsListItem() async {
        viewModel.cats = []
        let expectedCats = [Cat.dummyWithImage]
        useCases.cats = expectedCats

        await viewModel.viewAppear()

        XCTAssertEqual(viewModel.cats, [CatListItem(cat: expectedCats[0])])
    }

    @MainActor
    func test_GIVEN_a_cat_id_WHEN_setFavourite_is_called_THEN_should_call_setFavouriteCat() async {
        viewModel.setFavourite(id: "a-cat-id")
        
        XCTAssertEqual(useCases.setFavouriteCalled, true)
    }
}

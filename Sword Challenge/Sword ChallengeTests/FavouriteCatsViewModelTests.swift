
import Foundation
import XCTest
import Core
@testable import Sword_Challenge

final class FavouriteCatsViewModelTests: XCTestCase {

    private var viewModel: FavouriteCatsViewModel!
    private var useCases: CatsUseCasesStub!

    @MainActor
    override func setUp() {
        super.setUp()

        useCases = CatsUseCasesStub()
        viewModel = FavouriteCatsViewModel(catsUseCases: useCases)
    }

    override func tearDown() {
        super.tearDown()

        useCases = nil
        viewModel = nil
    }

    @MainActor
    func test_WHEN_viewAppear_is_called_THEN_should_call_get_favourite_cats() {
        viewModel.viewAppear()

        XCTAssertEqual(useCases.getFavouriteCatsCalled, true)
    }

    @MainActor
    func test_WHEN_setFavourite_is_called_THEN_should_call_set_favourite_cats() {
        viewModel.setFavourite(id: "favourite-cat-id")

        XCTAssertEqual(useCases.setFavouriteCalled, true)
        XCTAssertEqual(useCases.getFavouriteCatsCalled, true)
    }

    @MainActor
    func test_GIVEN_favouriteCats_WHEN_viewAppear_is_called_THEN_should_return_favourite_cats() {
        let expectedFavouriteCats = [Cat.dummyWithImage]
        let expectedCatListItem = [CatListItem(cat: expectedFavouriteCats[0])]
        useCases.favouriteCats = expectedFavouriteCats

        viewModel.viewAppear()

        XCTAssertEqual(viewModel.cats, expectedCatListItem)
    }

    @MainActor
    func test_GIVEN_favouriteCats_WHEN_viewAppear_is_called_THEN_should_get_favourite_cats_lifespan() {
        let expectedLifespan = 10
        useCases.averageLifespan = expectedLifespan

        viewModel.viewAppear()

        XCTAssertEqual(viewModel.averageLifeSpan, expectedLifespan)
    }

    @MainActor
    func test_GIVEN_favouriteCats_WHEN_viewAppear_is_called_THEN_should_show_lifespan() {
        let expectedFavouriteCats = [Cat.dummyWithImage]
        useCases.favouriteCats = expectedFavouriteCats

        viewModel.viewAppear()

        XCTAssertEqual(viewModel.showLifeSpan, true)
    }

    @MainActor
    func test_GIVEN_empty_favouriteCats_WHEN_viewAppear_is_called_THEN_should_not_show_lifespan() {
        viewModel.viewAppear()

        XCTAssertEqual(viewModel.showLifeSpan, false)
    }
}

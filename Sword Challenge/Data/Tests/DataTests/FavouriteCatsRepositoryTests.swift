
import XCTest
@testable import Data
@testable import Core

final class FavouriteCatsRepositoryTests: XCTestCase {
    
    private var favouriteCatsRepository: FavouriteCatsRepositoryImplementation!
    private var favouriteCatsPersistence: FavouriteCatsPersistenceStub!

    override func setUp() {
        super.setUp()

        favouriteCatsPersistence = FavouriteCatsPersistenceStub()
        favouriteCatsRepository = FavouriteCatsRepositoryImplementation(persistence: favouriteCatsPersistence)
    }

    override func tearDown() {
        super.tearDown()

        favouriteCatsPersistence = nil
        favouriteCatsRepository = nil
    }

    func test_GIVEN_a_cat_id_WHEN_delete_is_called_THEN_should_call_persistence_delete() throws {
        try favouriteCatsRepository.delete("a-cat-id")

        XCTAssertEqual(favouriteCatsPersistence.deleteCalled, true)
    }

    func test_GIVEN_a_cat_id_WHEN_find_is_called_THEN_should_call_persistence_find() throws {
        let _ = try favouriteCatsRepository.find("a-cat-id")

        XCTAssertEqual(favouriteCatsPersistence.findCalled, true)
    }

    func test_WHEN_findAll_is_called_THEN_should_call_persistence_findAll() throws {
        let _ = try favouriteCatsRepository.findAll()

        XCTAssertEqual(favouriteCatsPersistence.findAllCalled, true)
    }

    func test_GIVEN__WHEN__THEN_() {

    }
}

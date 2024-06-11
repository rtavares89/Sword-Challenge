
import Foundation
import Data

final class FavouriteCatsPersistenceStub: FavouriteCatsPersistenceDecorator {
    
    var insertCalled = false
    var deleteCalled = false
    var findCalled = false
    var findAllCalled = false

    var findEntity: FavouriteCatModel?
    var findAllEntities = [FavouriteCatModel]()

    func insert(_ cat: FavouriteCatModel) {
        insertCalled = true
    }
    
    func delete(_ catId: String) throws {
        deleteCalled = true
    }
    
    func find(_ catId: String) throws -> FavouriteCatModel? {
        findCalled = true

        return findEntity
    }
    
    func findAll() throws -> [FavouriteCatModel] {
        findAllCalled = true

        return findAllEntities
    }
}

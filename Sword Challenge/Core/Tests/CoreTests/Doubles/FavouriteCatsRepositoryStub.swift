
import Foundation
import Core

final class FavouriteCatsRepositoryStub: FavouriteCatsRepository {

    var insertCalled = false
    var deleteCalled = false
    var findCalled = false
    var findAllCalled = false

    var cat: Cat?
    var allCats = [Cat]()

    func insert(_ cat: Cat) throws {
        insertCalled = true
    }
    
    func delete(_ catId: String) throws {
        deleteCalled = true
    }
    
    func find(_ catId: String) throws -> Cat? {
        findCalled = true

        return cat
    }
    
    func findAll() throws -> [Cat] {
        findAllCalled = true

        return allCats
    }
}

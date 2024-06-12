
import Foundation
@testable import Core

final class CatsUseCasesStub: CatsUseCases {

    var fetchCatsCalled = false
    var getFavouriteCatsCalled = false
    var getCatCalled = false
    var searchCalled = false
    var setFavouriteCalled = false
    var favouritesAverageLifespanCalled = false

    var searchCompletion: (() -> Void)?

    var averageLifespan = 0
    var favouriteCats = [Cat]()
    var favouriteCat: Cat?
    var cat: Cat?

    var cats = [Cat]()

    func fetchCats(page: Int) async throws -> [Cat] {
        fetchCatsCalled = true

        return cats
    }
    
    func getFavouriteCats() -> [Cat] {
        getFavouriteCatsCalled = true

        return favouriteCats
    }
    
    func getCat(id: String) -> Cat? {
        getCatCalled = true

        return cat
    }
    
    func search(catBreed: String) async throws -> [Cat] {
        searchCalled = true
        searchCompletion?()

        return cats
    }
    
    func setFavourite(id: String) -> Cat? {
        setFavouriteCalled = true

        return favouriteCat
    }
    
    func favouritesAverageLifespan() -> Int {
        favouritesAverageLifespanCalled = true

        return averageLifespan
    }
}

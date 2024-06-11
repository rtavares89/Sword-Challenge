
import Foundation

public protocol FavouriteCatsRepository {
    func insert(_ cat: Cat)
    func delete(_ catId: String) throws
    func find(_ catId: String) throws -> Cat?
    func findAll() throws -> [Cat]
}

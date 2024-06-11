
import Foundation
import SwiftData

public protocol FavouriteCatsPersistenceDecorator {
    func insert(_ cat: FavouriteCatModel)
    func delete(_ catId: String) throws
    func find(_ catId: String) throws -> FavouriteCatModel?
    func findAll() throws -> [FavouriteCatModel]
}

public final class FavouriteCatsPersistence: FavouriteCatsPersistenceDecorator {

    private let modelContext: ModelContext

    public init() {
        let container = try! ModelContainer(for: FavouriteCatModel.self)
        modelContext = ModelContext(container)
    }

    public func insert(_ cat: FavouriteCatModel) {
        modelContext.insert(cat)
    }

    public func delete(_ catId: String) throws {
        let predicate = #Predicate<FavouriteCatModel> { cat in
            cat.id == catId
        }

        var fetchDescriptor = FetchDescriptor(predicate: predicate)
        fetchDescriptor.fetchLimit = 1

        guard let cat = try modelContext.fetch(fetchDescriptor).first else { return }

        modelContext.delete(cat)
    }

    public func find(_ catId: String) throws -> FavouriteCatModel? {
        let predicate = #Predicate<FavouriteCatModel> { cat in
            cat.id == catId
        }

        var fetchDescriptor = FetchDescriptor(predicate: predicate)
        fetchDescriptor.fetchLimit = 1

        guard let model = try modelContext.fetch(fetchDescriptor).first else { return nil }

        return model
    }

    public func findAll() throws -> [FavouriteCatModel] {
        return try modelContext.fetch(FetchDescriptor<FavouriteCatModel>())
    }
}

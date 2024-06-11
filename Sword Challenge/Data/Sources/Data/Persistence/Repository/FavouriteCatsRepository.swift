
import Foundation
import Core

public final class FavouriteCatsRepositoryImplementation: FavouriteCatsRepository {

    private let persistence: FavouriteCatsPersistenceDecorator

    public init(persistence: FavouriteCatsPersistenceDecorator) {
        self.persistence = persistence
    }

    public func insert(_ cat: Cat) {
        guard let model = FavouriteCatModel(cat: cat) else { return }
        persistence.insert(model)
    }
    
    public func delete(_ catId: String) throws {
        try persistence.delete(catId)
    }
    
    public func find(_ catId: String) throws -> Cat? {
        guard let model = try persistence.find(catId) else { return nil }

        return Cat(model: model)
    }

    public func findAll() throws -> [Cat] {
        return try persistence.findAll()
            .map { model in
                Cat(model: model)
            }
    }
}

extension Cat {
    init(model: FavouriteCatModel) {
        let breed = CatBreed(id: model.id,
                              name: model.name,
                              description: model.catDescription,
                              origin: model.origin,
                              temperament: model.temperament,
                              lifeSpan: model.lifespan,
                              imageId: model.imageId)
        let image = CatImage(id: model.imageId, url: model.imageUrl, data: model.image)

        self.init(breed: breed, image: image, isFavourite: true)
    }
}

extension FavouriteCatModel {
    convenience init?(cat: Cat) {

        guard let image = cat.image,
              let data = cat.image?.data 
        else { return nil }

        self.init(id: cat.breed.id,
                  name: cat.breed.name,
                  description: cat.breed.description,
                  origin: cat.breed.origin,
                  temperament: cat.breed.temperament, 
                  lifespan: cat.breed.lifeSpan,
                  imageId: cat.breed.imageId,
                  imageUrl: image.url,
                  image: data)
    }
}

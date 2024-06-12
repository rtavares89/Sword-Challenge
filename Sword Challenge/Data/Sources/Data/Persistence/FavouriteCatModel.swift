
import SwiftData
import Foundation

@Model
public final class FavouriteCatModel: Identifiable {
    @Attribute(.unique) public var id: String
    var name: String
    var catDescription: String
    var origin: String
    var temperament: String
    var lifespan: String
    var imageId: String?
    var imageUrl: String
    var image: Data

    init(id: String,
         name: String,
         description: String,
         origin: String,
         temperament: String,
         lifespan: String,
         imageId: String?,
         imageUrl: String,
         image: Data) {
        self.id = id
        self.name = name
        self.catDescription = description
        self.origin = origin
        self.temperament = temperament
        self.lifespan = lifespan
        self.imageId = imageId
        self.imageUrl = imageUrl
        self.image = image
    }
}

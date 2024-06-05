
import Foundation

public struct CatBreed {
    public var id: String
    public var name: String
    public var description: String
    public var origin: String
    public var temperament: String
    public var lifeSpan: String
    public var image: URL

    public init(id: String, name: String, description: String, origin: String, temperament: String, lifeSpan: String, image: URL) {
        self.id = id
        self.name = name
        self.description = description
        self.origin = origin
        self.temperament = temperament
        self.lifeSpan = lifeSpan
        self.image = image
    }
}

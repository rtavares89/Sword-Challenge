
import Foundation

public struct CatBreed {
    public var id: String
    public var name: String
    public var description: String
    public var origin: String
    public var temperament: String
    public var lifeSpan: String
    public var imageId: String

    public init(id: String, name: String, description: String, origin: String, temperament: String, lifeSpan: String, imageId: String) {
        self.id = id
        self.name = name
        self.description = description
        self.origin = origin
        self.temperament = temperament
        self.lifeSpan = lifeSpan
        self.imageId = imageId
    }
}

public struct CatImage {
    public var id: String
    public var url: String

    public init(id: String, url: String) {
        self.id = id
        self.url = url
    }
}


import Foundation

public struct Cat {
    public var breed: CatBreed
    public var image: CatImage?
    public var isFavourite = false

    public init(breed: CatBreed, image: CatImage?, isFavourite: Bool) {
        self.breed = breed
        self.image = image
        self.isFavourite = isFavourite
    }
}

extension Cat: Equatable { }

public struct CatBreed {
    public var id: String
    public var name: String
    public var description: String
    public var origin: String
    public var temperament: String
    public var lifeSpan: String
    public var imageId: String?

    public init(id: String, name: String, description: String, origin: String, temperament: String, lifeSpan: String, imageId: String?) {
        self.id = id
        self.name = name
        self.description = description
        self.origin = origin
        self.temperament = temperament
        self.lifeSpan = lifeSpan
        self.imageId = imageId
    }
}

extension CatBreed: Equatable { }

public struct CatImage {
    public var id: String
    public var url: String
    public var data: Data?

    public init(id: String, url: String, data: Data? = nil) {
        self.id = id
        self.url = url
        self.data = data
    }
}

extension CatImage: Equatable { }

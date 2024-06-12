
import Foundation
import Core
@testable import Sword_Challenge

extension Cat {
    static let dummy = Cat(breed: CatBreed.dummy, image: CatImage.dummy, isFavourite: true)
    static let dummyWithImage = Cat(breed: CatBreed.dummy2, image: CatImage.dummyWithData, isFavourite: true)
    static let dummyWithImageNotFavourite = Cat(breed: CatBreed.dummy2, image: CatImage.dummyWithData, isFavourite: false)
}

extension CatBreed {

    static let dummy = CatBreed(id: "cat-id",
                                name: "cat name",
                                description: "cat description",
                                origin: "cat origin",
                                temperament: "cat temperament",
                                lifeSpan: "8 - 10 lifespan",
                                imageId: "cat-image-id")

    static let dummy2 = CatBreed(id: "cat-id-2",
                                 name: "cat name",
                                 description: "cat description",
                                 origin: "cat origin",
                                 temperament: "cat temperament",
                                 lifeSpan: "10 - 15 lifespan",
                                 imageId: "cat-image-id-2")

}

extension CatImage {
    static let dummy = CatImage(id: "cat-image-id", url: "cat-image-url")
    static let dummyWithData = CatImage(id: "cat-image-id", url: "cat-image-url", data: Data())
    static let dummyWithData2 = CatImage(id: "cat-image-id-2", url: "cat-image-url", data: Data())
}

extension CatListItem {
    static let dummy = CatListItem(id: "cat-id", name: "Cat Name", image: Data(), isFavourite: false)
    static let dummyFavourite = CatListItem(id: "cat-id", name: "Cat Name", image: Data(), isFavourite: true)
}

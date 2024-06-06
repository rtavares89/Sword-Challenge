
import Foundation
import Core

struct CatBreedResponse: Decodable {
    var id: String
    var name: String
    var description: String
    var origin: String
    var temperament: String
    var lifeSpan: String
    var referenceImageId: String
}

struct CatImage: Decodable {
    var id: String
    var url: String
}

extension CatBreed {

    init(catResponse: CatBreedResponse) {
        self.init(id: catResponse.id,
                  name: catResponse.name,
                  description: catResponse.description,
                  origin: catResponse.origin,
                  temperament: catResponse.temperament,
                  lifeSpan: catResponse.lifeSpan,
                  imageId: catResponse.referenceImageId)
    }
}


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

struct CatImageResponse: Decodable {
    var id: String
    var url: String
}

extension CatBreed {

    init(catBreedResponse: CatBreedResponse) {
        self.init(id: catBreedResponse.id,
                  name: catBreedResponse.name,
                  description: catBreedResponse.description,
                  origin: catBreedResponse.origin,
                  temperament: catBreedResponse.temperament,
                  lifeSpan: catBreedResponse.lifeSpan,
                  imageId: catBreedResponse.referenceImageId)
    }
}

extension CatImage {

    init(catImageResponse: CatImageResponse) {
        self.init(id: catImageResponse.id,
                  url: catImageResponse.url)
    }
}

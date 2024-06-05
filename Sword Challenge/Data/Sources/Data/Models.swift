
import Foundation
import Core

struct CatBreedResponse: Decodable {
    var id: String
    var name: String
    var description: String
    var origin: String
    var temperament: String
    var lifeSpan: String
    var image: CatImage
}

struct CatImage: Decodable {
    var id: String
    var url: String
}

extension CatBreed {

    init?(catResponse: CatBreedResponse) {

        guard let imageUrl = URL(string: catResponse.image.url) else { return nil}

        self.init(id: catResponse.id,
                  name: catResponse.name,
                  description: catResponse.description,
                  origin: catResponse.origin,
                  temperament: catResponse.temperament,
                  lifeSpan: catResponse.lifeSpan,
                  image: imageUrl)
    }
}


import Foundation
import Core

struct CatBreedsResponse: Decodable {
    var id: String
    var name: String
    var description: String
    var origin: String
    var temperament: String
    var lifeSpan: String
    var referenceImageId: String?
}

extension CatBreed {

    init(catBreedResponse: CatBreedsResponse) {
        self.init(id: catBreedResponse.id,
                  name: catBreedResponse.name,
                  description: catBreedResponse.description,
                  origin: catBreedResponse.origin,
                  temperament: catBreedResponse.temperament,
                  lifeSpan: catBreedResponse.lifeSpan,
                  imageId: catBreedResponse.referenceImageId)
    }
}

#if DEBUG

extension CatBreedsResponse {
    static let mock = CatBreedsResponse(id: "catId",
                                        name: "cat name",
                                        description: "cat description",
                                        origin: "cat origin",
                                        temperament: "cat temperament",
                                        lifeSpan: "cat life span",
                                        referenceImageId: "imageId")
}

#endif

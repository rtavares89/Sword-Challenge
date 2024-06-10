
import Foundation
import Core

struct CatListItem: Hashable {
    var id: String
    var name: String
    var image: Data
    var isFavorite: Bool
}

extension CatListItem {

    init?(cat: Cat) {
        guard let imageData = cat.image?.data else { return nil }

        self.id = cat.breed.id
        self.name = cat.breed.name
        self.image = imageData
        self.isFavorite = false
    }
}

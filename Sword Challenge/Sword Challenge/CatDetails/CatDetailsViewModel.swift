
import Foundation

@Observable
@MainActor
final class CatDetailsViewModel {
    
    var name: String
    var origin: String
    var temperament: String
    var description: String
    var isFavorite: String

    init(name: String, origin: String, temperament: String, description: String, isFavorite: String) {
        self.name = name
        self.origin = origin
        self.temperament = temperament
        self.description = description
        self.isFavorite = isFavorite
    }

    func favoriteButtonTapped() {
        
    }
}

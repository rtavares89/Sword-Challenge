
import Foundation
import Core

@Observable
@MainActor
final class FavouriteCatsViewModel {
    
    private let catsUseCases: CatsUseCases
    var cats = [CatListItem]()
    var averageLifeSpan = 0
    var showLifeSpan: Bool {
        !cats.isEmpty
    }

    init(catsUseCases: CatsUseCases) {
        self.catsUseCases = catsUseCases
    }

    func viewAppear() {
        do {
            try getFavouriteCats()
        } catch {

        }
    }

    func setFavourite(id: String) {
        let _ = catsUseCases.setFavourite(id: id)

        do {
            try getFavouriteCats()
        } catch {

        }
    }

    private func getFavouriteCats() throws {
        cats = try catsUseCases.getFavouriteCats().compactMap({ cat in
            CatListItem(cat: cat)
        })

        averageLifeSpan = catsUseCases.favouritesAverageLifespan()
    }
}


import Foundation
import Core

@Observable
@MainActor
final class FavouriteCatsViewModel {
    
    private let catsUseCases: CatsUseCases
    var cats = [CatListItem]()

    init(catsUseCases: CatsUseCases) {
        self.catsUseCases = catsUseCases
    }

    func viewAppear() {
        getFavouriteCats()
    }

    func setFavourite(id: String) {
        let _ = catsUseCases.setFavourite(id: id)

        getFavouriteCats()
    }

    private func getFavouriteCats() {
        cats = catsUseCases.getFavouriteCats().compactMap({ cat in
            CatListItem(cat: cat)
        })
    }
}

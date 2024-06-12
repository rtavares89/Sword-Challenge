
import Foundation
import Core

@Observable
@MainActor
final class CatDetailsViewModel {

    var cat: Cat?
    private let catsUseCases: CatsUseCases
    var isFavourite: Bool {
        cat?.isFavourite ?? false
    }
    var favouriteImage: String {
        isFavourite ? "star.fill" : "star"
    }

    init(catsUseCases: CatsUseCases) {
        self.catsUseCases = catsUseCases
    }

    func viewAppear(catId: String) {
        cat = catsUseCases.getCat(id: catId)
    }

    func favoriteButtonTapped() {
        guard let cat else { return }

        self.cat = catsUseCases.setFavourite(id: cat.breed.id)
    }
}

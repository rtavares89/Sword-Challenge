
import Foundation
import Core

@Observable
@MainActor
final class CatDetailsViewModel {

    var cat: Cat?
    private let catsUseCases: CatsUseCases

    init(catsUseCases: CatsUseCases) {
        self.catsUseCases = catsUseCases
    }

    func viewAppear(catId: String) {
        cat = catsUseCases.getCat(id: catId)

        print(cat)
    }

    func favoriteButtonTapped() {
        
    }
}

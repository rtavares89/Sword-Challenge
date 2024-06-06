
import Foundation
import Core

@Observable
@MainActor
final class CatsListViewModel {
    
//    var cats = [CatListItem]()
    var cats = [
        CatListItem(name: "1", image: "", isFavorite: false),
        CatListItem(name: "2", image: "", isFavorite: false),
        CatListItem(name: "3", image: "", isFavorite: false),
        CatListItem(name: "4", image: "", isFavorite: false),
        CatListItem(name: "5", image: "", isFavorite: false)
    ]
    var searchText: String = ""

    private let catsUseCases: CatsUseCases

    init(catsUseCases: CatsUseCases) {
        self.catsUseCases = catsUseCases
    }

    func viewAppear() async {
        do {
            let cats = try await catsUseCases.fetchCatBreeds(page: 0)

            print(cats)
        } catch {
            print(error)
        }
    }
}

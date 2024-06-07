
import Foundation
import Core

@Observable
@MainActor
final class CatsListViewModel {
    
//    var cats = [CatListItem]()
    var cats = [
        CatListItem(id: UUID().uuidString, name: "1", image: Data(), isFavorite: false),
        CatListItem(id: UUID().uuidString, name: "2", image: Data(), isFavorite: false),
        CatListItem(id: UUID().uuidString, name: "3", image: Data(), isFavorite: false),
        CatListItem(id: UUID().uuidString, name: "4", image: Data(), isFavorite: false),
        CatListItem(id: UUID().uuidString, name: "5", image: Data(), isFavorite: false)
    ]
    var searchText: String = ""
    var isLoading = false

    private let catsUseCases: CatsUseCases

    init(catsUseCases: CatsUseCases) {
        self.catsUseCases = catsUseCases
    }

    func viewAppear() async {
        
        defer { isLoading = false }

        isLoading = true

        do {
            let cats = try await catsUseCases.fetchCats(page: 0)

            print(cats)

            self.cats = cats.map({ cat in
                CatListItem(id: cat.breed.id, name: cat.breed.name, image: cat.image!.data!, isFavorite: false)
            })
        } catch {
            print(error)
        }
    }
}

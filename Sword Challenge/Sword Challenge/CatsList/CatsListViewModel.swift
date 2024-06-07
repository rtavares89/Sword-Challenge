
import Foundation
import Core

@Observable
@MainActor
final class CatsListViewModel {
    
    var cats = [CatListItem]()
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

            self.cats = cats.compactMap({ cat in
                guard let imageData = cat.image?.data else { return nil }

                return CatListItem(id: cat.breed.id, name: cat.breed.name, image: imageData, isFavorite: false)
            })
        } catch {
            print(error)
        }
    }
}

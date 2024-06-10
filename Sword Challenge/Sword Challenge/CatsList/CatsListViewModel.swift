
import Foundation
import Combine
import Core

@Observable
@MainActor
final class CatsListViewModel {
    
    var cats = [CatListItem]()
    var searchText = "" {
        didSet {
            searchTextPublisher.send(searchText)
        }
    }
    var isLoading = false
    private var searchSubscription: AnyCancellable?
    private var searchTextPublisher = PassthroughSubject<String, Never>()

    private let catsUseCases: CatsUseCases

    init(catsUseCases: CatsUseCases) {
        self.catsUseCases = catsUseCases

        subscribeSearchTextChanges()
    }

    func viewAppear() async {

        defer { isLoading = false }

        isLoading = true

        do {
            let cats = try await catsUseCases.fetchCats(page: 0)

            print(cats)

            self.cats = cats.compactMap({ cat in
                CatListItem(cat: cat)
            })
        } catch {
            print(error)
        }
    }

    private func subscribeSearchTextChanges() {
        searchSubscription = searchTextPublisher
            .removeDuplicates()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] text in
                guard let self, !text.isEmpty else { return }

                Task {
                    let cats = try await self.catsUseCases.search(catBreed: text)

                    self.cats = cats.compactMap({ cat in
                        CatListItem(cat: cat)
                    })
                }
            }
    }
}

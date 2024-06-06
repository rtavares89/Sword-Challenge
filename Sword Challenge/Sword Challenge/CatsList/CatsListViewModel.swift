
import Foundation

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
}

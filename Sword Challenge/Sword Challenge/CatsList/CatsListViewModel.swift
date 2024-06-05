
import Foundation

@Observable
@MainActor
final class CatsListViewModel {
    
    var cats = [CatListItem]()
    var searchText: String = ""
}


import SwiftUI

struct CatsTabView: View {

    @Bindable var viewModel: CatsTabViewModel
    let catsListViewModel: CatsListViewModel
    let favouriteCatsViewModel: FavouriteCatsViewModel

    var body: some View {

        TabView(selection: $viewModel.selectedTab) {

            NavigationStack {
                CatsListView(viewModel: catsListViewModel)
                    .navigationTitle("Cats App")
            }
            .tabItem {
                Label("Cats", systemImage: "list.bullet")
            }
            .tag(CatTab.list)

            NavigationStack {
                FavouriteCatsView(viewModel: favouriteCatsViewModel)
                    .navigationTitle("Favourites")
            }
            .tabItem {
                Label("Favourites", systemImage: "star")
            }
            .tag(CatTab.favourites)
        }
    }
}

#Preview("Cats List") {
    CatsTabView(viewModel: CatsTabViewModel(selectedTab: .list),
                catsListViewModel: CatsListViewModel(catsUseCases: DependencyManager.shared.catsUseCases), 
                favouriteCatsViewModel: FavouriteCatsViewModel(catsUseCases: DependencyManager.shared.catsUseCases))
}

#Preview("Favourites") {
    CatsTabView(viewModel: CatsTabViewModel(selectedTab: .favourites),
                catsListViewModel: CatsListViewModel(catsUseCases: DependencyManager.shared.catsUseCases),
                favouriteCatsViewModel: FavouriteCatsViewModel(catsUseCases: DependencyManager.shared.catsUseCases))
}

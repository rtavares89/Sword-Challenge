
import SwiftUI

struct CatsTabView: View {

    @Bindable var viewModel: CatsTabViewModel

    var body: some View {

        TabView(selection: $viewModel.selectedTab) {

            NavigationStack {
                CatsListView(viewModel: CatsListViewModel())
                    .navigationTitle("Cats App")
            }
            .searchable(text: .constant(""))
            .tabItem {
                Label("Cats", systemImage: "list.bullet")
            }
            .tag(CatTab.list)

            NavigationStack {
                FavouritesCatsView()
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
    CatsTabView(viewModel: CatsTabViewModel(selectedTab: .list))
}

#Preview("Favourites") {
    CatsTabView(viewModel: CatsTabViewModel(selectedTab: .favourites))
}

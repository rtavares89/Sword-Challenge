
import SwiftUI

struct CatsListView: View {

    @State var searchText: String = ""
    @Bindable var viewModel: CatsListViewModel

    var body: some View {
        NavigationStack {
            Text("Hello, World!")
                .navigationTitle("Cats App")
        }
        .searchable(text: $viewModel.searchText)
    }
}

#Preview {
    CatsListView(viewModel: CatsListViewModel(cats: []))
}

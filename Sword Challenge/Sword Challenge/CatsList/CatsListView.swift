
import SwiftUI

struct CatsListView: View {

    @Bindable var viewModel: CatsListViewModel

    var body: some View {

        VStack {

            Text("Cats List")

            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())], content: {
//                    Text("Placeholder")
//                    Text("Placeholder")

                    ForEach(viewModel.cats, id: \.self) { cat in
                        CatListItemView()
                    }
                })
            }

            NavigationLink {
                Text("View")
                    .navigationTitle("Details")
            } label: {
                Text("Next")
            }
        }
    }
}

#Preview {
    CatsListView(viewModel: CatsListViewModel())
}

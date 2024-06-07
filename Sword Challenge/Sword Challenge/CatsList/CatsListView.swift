
import SwiftUI

struct CatsListView: View {

    @Bindable var viewModel: CatsListViewModel

    var body: some View {

        VStack {

            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())], content: {
                    ForEach(viewModel.cats, id: \.self) { cat in
                        CatListItemView(name: cat.name, imageData: cat.image)
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
        .task {
            await viewModel.viewAppear()
        }
    }
}

#Preview {
    CatsListView(
        viewModel:
            CatsListViewModel(
                catsUseCases: DependencyManager.shared.catsUseCases
            )
    )
}

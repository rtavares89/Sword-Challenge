
import SwiftUI

struct CatsListView: View {

    @Bindable var viewModel: CatsListViewModel

    var body: some View {

        VStack {

            if viewModel.isLoading {
                ProgressView()
            } else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()),GridItem(.flexible())]) {
                        ForEach(viewModel.cats, id: \.self) { cat in
                            NavigationLink {
                                let viewModel = CatDetailsViewModel(catsUseCases: DependencyManager.shared.catsUseCases)

                                CatDetailsView(viewModel: viewModel)
                                    .onAppear {
                                        viewModel.viewAppear(catId: cat.id)
                                    }
                            } label: {
                                CatListItemView(name: cat.name, imageData: cat.image)
                                    .overlay {
                                        VStack{
                                            HStack {
                                                Spacer()

                                                Button {
                                                    viewModel.setFavourite(id: cat.id)
                                                } label: {
                                                    Image(systemName: cat.isFavourite ? "star.fill" : "star")
                                                        .resizable()
                                                        .foregroundColor(.blue)
                                                        .frame(width: 40, height: 40)
                                                }
                                            }

                                            Spacer()
                                        }
                                    }
                            }
                        }

                        if viewModel.showLoadMore {
                            ProgressView()
                                .task {
                                    await viewModel.fetchNextPage()
                                }
                        }
                    }
                }
            }
        }
        .searchable(text: $viewModel.searchText)
        .autocorrectionDisabled()
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

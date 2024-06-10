
import SwiftUI

struct CatDetailsView: View {

    let viewModel: CatDetailsViewModel!

    var body: some View {
        VStack(spacing: 10) {

            if let imageData = viewModel.cat?.image?.data, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            }

            VStack {
                HStack {
                    Text("Origin")
                    Spacer()
                }

                HStack {
                    Text(viewModel.cat?.breed.origin ?? "")
                        .bold()
                    Spacer()
                }

            }

            VStack(alignment: .leading) {
                HStack {
                    Text("Temperament")
                    Spacer()
                }

                HStack {
                    Text(viewModel.cat?.breed.temperament ?? "")
                        .bold()
                    Spacer()
                }
            }

            Text(viewModel.cat?.breed.description ?? "")
        }
        .navigationTitle(viewModel.cat?.breed.name ?? "")
        .toolbar {
            Button {
                viewModel.favoriteButtonTapped()
            } label: {
                Image(systemName: viewModel.favouriteImage)
            }
        }
    }
}

#Preview {
    CatDetailsView(viewModel: CatDetailsViewModel(catsUseCases: DependencyManager.shared.catsUseCases))
}

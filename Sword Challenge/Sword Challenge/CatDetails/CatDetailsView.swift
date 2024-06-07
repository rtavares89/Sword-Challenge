
import SwiftUI

struct CatDetailsView: View {

    let viewModel: CatDetailsViewModel!

    var body: some View {
        VStack {

            if let imageData = viewModel.cat?.image?.data, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            }

            Text(viewModel.cat?.breed.description ?? "")
        }
        .navigationTitle(viewModel.cat?.breed.name ?? "")
    }
}

#Preview {
    CatDetailsView(viewModel: CatDetailsViewModel(catsUseCases: DependencyManager.shared.catsUseCases))
}

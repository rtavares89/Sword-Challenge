
import SwiftUI

struct CatsListView: View {

    @Bindable var viewModel: CatsListViewModel

    var body: some View {

        VStack {

            Text("Cats List")

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

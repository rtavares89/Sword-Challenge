
import SwiftUI

struct CatListItemView: View {
    var body: some View {
        VStack {
            Image(systemName: "star")
            Text("Cat")
        }
    }
}

#Preview {
    CatListItemView()
}

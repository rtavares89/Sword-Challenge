
import SwiftUI

struct CatListItemView: View {

    let name: String
    let imageData: Data

    var body: some View {
        VStack {
            if let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            }
            Text(name)
        }
    }
}

#Preview {
    CatListItemView(name: "Cat", imageData: Data())
}


import SwiftUI

@main
struct Sword_ChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            CatsTabView(viewModel: CatsTabViewModel(selectedTab: .favourites))
        }
    }
}

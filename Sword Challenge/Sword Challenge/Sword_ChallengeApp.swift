
import SwiftUI

@main
struct Sword_ChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            CatsTabView(viewModel: CatsTabViewModel(),
                        catsListViewModel: CatsListViewModel(catsUseCases: DependencyManager.shared.catsUseCases),
                        favouriteCatsViewModel: FavouriteCatsViewModel(catsUseCases: DependencyManager.shared.catsUseCases))
        }
    }
}

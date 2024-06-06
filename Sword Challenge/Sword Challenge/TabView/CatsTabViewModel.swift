//
//  CatsTabViewModel.swift
//  Sword Challenge
//
//  Created by Ricardo Tavares on 05/06/2024.
//

import Foundation

enum CatTab {
    case list, favourites
}

@Observable
@MainActor
final class CatsTabViewModel {
    
    var selectedTab: CatTab = .list

    init(selectedTab: CatTab = .list) {
        self.selectedTab = selectedTab
    }
}

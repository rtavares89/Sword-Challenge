//
//  FavoritesCatsView.swift
//  Sword Challenge
//
//  Created by Ricardo Tavares on 05/06/2024.
//

import SwiftUI

struct FavouriteCatsView: View {

    let viewModel: FavouriteCatsViewModel

    var body: some View {

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
            }
        }
        .onAppear {
            viewModel.viewAppear()
        }

        if viewModel.showLifeSpan {
            Text("Average lifespan: \(viewModel.averageLifeSpan)")
        }
    }
}

#Preview {
    FavouriteCatsView(viewModel: FavouriteCatsViewModel(catsUseCases: DependencyManager.shared.catsUseCases))
}

//
//  FavoritesListView.swift
//  ios-abschluss
//
//  Created by Michel Lobbos on 20.06.24.
//

import SwiftUI

struct FavoritesListView: View {
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel

    var body: some View {
        VStack {
            if favoritesViewModel.favoriteProducts.isEmpty {
                Text("No favorite products yet.")
                    .font(.title)
                    .foregroundColor(.gray)
            } else {
                List {
                    ForEach(favoritesViewModel.favoriteProducts.indices, id: \.self) { index in
                        NavigationLink(destination: DetailView(products: favoritesViewModel.favoriteProducts, selectedIndex: index)) {
                            HStack {
                                AsyncImage(url: URL(string: favoritesViewModel.favoriteProducts[index].image)) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image.resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                    case .failure:
                                        Image(systemName: "exclamationmark.triangle")
                                            .foregroundColor(.red)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                .frame(width: 50, height: 50) // Ensure the image has a fixed size

                                Text(favoritesViewModel.favoriteProducts[index].title)
                                    .font(.headline)
                                    .padding(.leading, 10)

                                Spacer()
                            }
                            .frame(height: 60) // Fixed height for each item
                        }
                    }
                }
            }
        }
        .navigationTitle("Favorites")
    }
}

struct FavoritesListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FavoritesListView()
                .environmentObject(FavoritesViewModel())
        }
    }
}

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
                    ForEach(favoritesViewModel.favoriteProducts) { product in
                        NavigationLink(destination: DetailView(product: product)) {
                            HStack {
                                AsyncImage(url: URL(string: product.image)) { phase in
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
                                
                                Text(product.title)
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

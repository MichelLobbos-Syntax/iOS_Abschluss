//
//  FavoritesViewModel.swift
//  ios-abschluss
//
//  Created by Michel Lobbos on 20.06.24.
//

import SwiftUI

class FavoritesViewModel: ObservableObject {
    @Published var favoriteProducts: [Product] = []
    
    func addToFavorites(_ product: Product) {
        if !favoriteProducts.contains(where: { $0.id == product.id }) {
            favoriteProducts.append(product)
        }
    }
    
    func removeFromFavorites(_ product: Product) {
        if let index = favoriteProducts.firstIndex(where: { $0.id == product.id }) {
            favoriteProducts.remove(at: index)
        }
    }
    
    func isFavorite(_ product: Product) -> Bool {
        favoriteProducts.contains(where: { $0.id == product.id })
    }
}

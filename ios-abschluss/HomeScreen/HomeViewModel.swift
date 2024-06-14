//
//  HomeViewModel.swift
//  ios-abschluss
//
//  Created by Michel Lobbos on 11.06.24.
//

import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var searchText: String = ""
    @Published var selectedCategory: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchProducts()
    }
    
    var filteredProducts: [Product] {
        products.filter { product in
            (selectedCategory == nil || product.category == selectedCategory) &&
            (searchText.isEmpty || product.title.lowercased().contains(searchText.lowercased()))
        }
    }
    
    func fetchProducts() {
        ApiService.shared.fetchProducts()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching products: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] products in
                self?.products = products
            })
            .store(in: &cancellables)
    }
}

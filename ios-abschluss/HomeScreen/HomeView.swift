//
//  HomeView.swift
//  ios-abschluss
//
//  Created by Michel Lobbos on 10.06.24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
//                SearchBarView(text: $viewModel.searchText)
//                    .padding(.horizontal)
                ScrollView(.horizontal) {
                    HStack {
                        FilterButtonView(title: "All", selectedCountry: $viewModel.selectedCategory, country: nil)
                        FilterButtonView(title: "Electronics", selectedCountry: $viewModel.selectedCategory, country: "electronics")
                        FilterButtonView(title: "Jewelery", selectedCountry: $viewModel.selectedCategory, country: "jewelery")
                        FilterButtonView(title: "Men's Clothing", selectedCountry: $viewModel.selectedCategory, country: "men's clothing")
                        FilterButtonView(title: "Women's Clothing", selectedCountry: $viewModel.selectedCategory, country: "women's clothing")
                    }
                    .padding(.horizontal)
                }
                
                            
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(viewModel.filteredProducts) { product in
                            NavigationLink(destination: DetailView(product: product)) {
                                ProductCardView(product: product)
                            }
                        }
                    }
                    .padding(.vertical, 7)
                    .padding(.horizontal)
                }
                .searchable(text: $viewModel.searchText, prompt: "Search products")
                    
                
                            
                .navigationTitle("Mate Mundo")
              
            }
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
        }
    }
}

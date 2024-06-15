import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    var body: some View {
        NavigationStack {
            VStack(spacing: 8) {
                // Filter Buttons
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        FilterButtonView(title: "All", icon: "rectangle.grid.2x2", selectedCategory: $viewModel.selectedCategory, category: nil)
                        FilterButtonView(title: "Electronics", icon: "ipad", selectedCategory: $viewModel.selectedCategory, category: "electronics")
                        FilterButtonView(title: "Jewelery", icon: "sparkles", selectedCategory: $viewModel.selectedCategory, category: "jewelery")
                        FilterButtonView(title: "Men's Clothing", icon: "tshirt", selectedCategory: $viewModel.selectedCategory, category: "men's clothing")
                        FilterButtonView(title: "Women's Clothing", icon: "handbag", selectedCategory: $viewModel.selectedCategory, category: "women's clothing")
                    }
                    .padding(.horizontal)
                }
                
                // Product Grid
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)], spacing: 10) {
                        ForEach(viewModel.filteredProducts) { product in
                            NavigationLink(destination: DetailView(product: product)) {
                                ProductCardView(product: product)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
            }
            .searchable(text: $viewModel.searchText)
            .navigationTitle("Abschuss")
            .background(Color(.systemBackground)) // Use system background color
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
                .environment(\.colorScheme, .light) // Preview in light mode
//            HomeView()
//                .environment(\.colorScheme, .dark) // Preview in dark mode
        }
    }
}

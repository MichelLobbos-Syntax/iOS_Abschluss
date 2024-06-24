import SwiftUI

struct HomeView: View {
    
    @State var text : String = ""
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        
        NavigationStack {
            
            ZStack{
//                AnimatedBackground()
                
            VStack(spacing: 8) {
                SearchBarView(text: $viewModel.searchText)
                    .padding(.horizontal)
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
                        ForEach(viewModel.filteredProducts.indices, id: \.self) { index in
                            NavigationLink(destination: DetailView(products: viewModel.filteredProducts, selectedIndex: index)) {
                                ProductCardView(product: viewModel.filteredProducts[index])
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: FavoritesListView()) {
                        Image(systemName: "heart.fill")
                    }
                }
            }
        }
        }
        .background(Color(.systemBackground)) // Use system background color
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
                .environmentObject(HomeViewModel())
                .environmentObject(FavoritesViewModel())
                .environmentObject(CartViewModel())
                .environment(\.colorScheme, .light) // Preview in light mode
        }
    }
}

//
//  DetailView.swift
//  ios-abschluss
//
//  Created by Michel Lobbos on 11.06.24.
//



import SwiftUI

struct Review: Identifiable {
    let id = UUID()
    let username: String
    let rating: Int
    let text: String
}

import SwiftUI

struct DetailView: View {
    let products: [Product]
    @State var selectedIndex: Int
    @State private var showOrderSheet: Bool = false
    @State private var orderQuantity: Int = 1
    @State private var selectedColor: String = "Red"
    @State private var selectedSize: String = "M"
    @State private var showReviewSheet: Bool = false
    @State private var rating: Int = 3
    @State private var reviewText: String = ""
    @State private var showToast: Bool = false
    @State private var toastMessage: String = ""
    
    @EnvironmentObject var cartViewModel: CartViewModel
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    let colors = ["Red", "Green", "Blue"]
    let sizes = ["S", "M", "L"]
    
    // Example reviews
    let reviews: [Review] = [
        Review(username: "Alice", rating: 5, text: "Great product! Very satisfied."),
        Review(username: "Bob", rating: 4, text: "Good quality, fast delivery."),
        Review(username: "Charlie", rating: 3, text: "Not bad, could be better."),
    ]
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            ForEach(products.indices, id: \.self) { index in
                productDetailView(product: products[index])
                    .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
    
    func productDetailView(product: Product) -> some View {
        VStack {
            HStack {
                Spacer()
                ZStack {
                    AsyncImage(url: URL(string: product.image)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image.resizable()
                                .scaledToFit()
                                .frame(height: 200)
                        case .failure:
                            Image(systemName: "exclamationmark.triangle")
                                .foregroundColor(.red)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .padding(.horizontal, 100)
                    .background(Color.white)
                    
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: {
                                if favoritesViewModel.isFavorite(product) {
                                    favoritesViewModel.removeFromFavorites(product)
                                } else {
                                    favoritesViewModel.addToFavorites(product)
                                }
                            }) {
                                Image(systemName: favoritesViewModel.isFavorite(product) ? "heart.fill" : "heart")
                                    .foregroundColor(favoritesViewModel.isFavorite(product) ? .red : .gray)
                                    .padding()
                            }
                        }
                        Spacer()
                    }
                }
                Spacer()
            }
            .padding()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text(product.title)
                            .font(.headline)
                            .padding()
                        Spacer()
                        Button(action: {
                            showOrderSheet = true
                        }) {
                            Image(systemName: "cart.badge.plus")
                                .resizable()
                                .frame(width: 40, height: 35)
                        }
                        .frame(width: 50, height: 50)
                        .shadow(radius: 5)
                    }
                    
                    HStack {
                        Text("Price:")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("\(product.price, specifier: "%.2f") €")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical, 5)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Description:")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Text(product.description)
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                    .padding(.top, 10)
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Reviews:")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        ForEach(reviews) { review in
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: "person.fill")
                                    Text(review.username)
                                        .font(.headline)
                                    Spacer()
                                    ForEach(1...5, id: \.self) { index in
                                        Image(systemName: index <= review.rating ? "star.fill" : "star")
                                            .foregroundColor(.yellow)
                                            .font(.caption)
                                    }
                                }
                                Text(review.text)
                                    .font(.body)
                                    .foregroundColor(.primary)
                            }
                            .padding()
                            .background(Color(.systemGray5))
                            .cornerRadius(10)
                        }
                    }
                    .padding(.top, 10)
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Your Review:")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        HStack {
                            ForEach(1...5, id: \.self) { index in
                                Image(systemName: index <= rating ? "star.fill" : "star")
                                    .foregroundColor(.yellow)
                                    .onTapGesture {
                                        rating = index
                                    }
                            }
                        }
                        
                        Button(action: {
                            showReviewSheet = true
                        }) {
                            Text("Leave a review")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                        .sheet(isPresented: $showReviewSheet) {
                            VStack(spacing: 20) {
                                Spacer()
                                Spacer()
                                Text("Leave a review")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                
                                TextEditor(text: $reviewText)
                                    .frame(height: 100)
                                    .padding()
                                
                                Button("Submit") {
                                    showReviewSheet = false
                                    showToast = true
                                    toastMessage = "Review submitted!"
                                }
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(20)
                                
                                Spacer()
                            }
                            .presentationDetents([.fraction(0.5)]) // Sheet takes 50% of the screen
                        }
                    }
                    .padding(.top, 10)
                    
                    if showToast {
                        Text(toastMessage)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    showToast = false
                                }
                            }
                    }
                }
                .padding(20)
                .background(Color(.systemGray6))
                .cornerRadius(20)
                .shadow(radius: 5)
                .padding()
            }
        }
        .navigationTitle(product.title)
        .sheet(isPresented: $showOrderSheet) {
            VStack(spacing: 20) {
                Spacer()
                Spacer()
                Text("Order")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Picker("Color", selection: $selectedColor) {
                    ForEach(colors, id: \.self) { color in
                        Text(color).tag(color)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Picker("Size", selection: $selectedSize) {
                    ForEach(sizes, id: \.self) { size in
                        Text(size).tag(size)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                HStack {
                    Spacer()
                    Button(action: {
                        if orderQuantity > 1 {
                            orderQuantity -= 1
                        }
                    }) {
                        Image(systemName: "minus.circle")
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                    Spacer()
                    Text("\(orderQuantity)")
                        .font(.title)
                        .padding(.horizontal)
                    Spacer()
                    Button(action: {
                        orderQuantity += 1
                    }) {
                        Image(systemName: "plus.circle")
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                    Spacer()
                }
                .padding()
                
                Button("Add to cart") {
                    cartViewModel.addToCart(product, quantity: orderQuantity, color: selectedColor, size: selectedSize)
                    showOrderSheet = false
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                
                Spacer()
            }
            .presentationDetents([.fraction(0.5)]) // Sheet takes 50% of the screen
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(products: [Product(id: 1, title: "Sample Product 1", price: 29.99, description: "This is a sample product description.", category: "electronics", image: "https://via.placeholder.com/150"),
                              Product(id: 2, title: "Sample Product 2", price: 49.99, description: "This is another sample product description.", category: "jewelery", image: "https://via.placeholder.com/150")],
                   selectedIndex: 0)
        .environmentObject(CartViewModel())
        .environmentObject(FavoritesViewModel())
    }
}

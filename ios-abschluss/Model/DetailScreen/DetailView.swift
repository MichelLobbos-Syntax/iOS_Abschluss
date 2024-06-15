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

struct DetailView: View {
    let product: Product
    @State private var isFavorite: Bool = false
    @State private var showToast: Bool = false
    @State private var toastMessage: String = ""
    @State private var showOrderSheet: Bool = false
    @State private var orderQuantity: Int = 1
    @State private var selectedColor: String = "Red"
    @State private var selectedSize: String = "M"
    @State private var showReviewSheet: Bool = false
    @State private var rating: Int = 3
    @State private var reviewText: String = ""
    
    @EnvironmentObject var cartViewModel: CartViewModel
    
    let colors = ["Red", "Green", "Blue"]
    let sizes = ["S", "M", "L"]
    
    // Beispielbewertungen
    let reviews: [Review] = [
        Review(username: "Alice", rating: 5, text: "Tolles Produkt! Sehr zufrieden."),
        Review(username: "Bob", rating: 4, text: "Gute Qualität, schnelle Lieferung."),
        Review(username: "Charlie", rating: 3, text: "Nicht schlecht, könnte besser sein."),
    ]
    
    var body: some View {
        
        VStack {
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
                        Text("Preis:")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("\(product.price, specifier: "%.2f") €")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical, 5)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Beschreibung:")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Text(product.description)
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                    .padding(.top, 10)
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Bewertungen:")
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
                        Text("Deine Bewertung:")
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
                            Text("Eine Bewertung abgeben")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                        .sheet(isPresented: $showReviewSheet) {
                            VStack(spacing: 20) {
                                Spacer()
                                Spacer()
                                Text("Bewertung abgeben")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                
                                TextEditor(text: $reviewText)
                                    .frame(height: 100)
                                    .padding()
                                
                                Button("Abschicken") {
                                    // Hier könntest du die Bewertung speichern oder verarbeiten
                                    showReviewSheet = false
                                    showToast = true
                                    toastMessage = "Bewertung abgeschickt!"
                                }
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(20)
                                
                                Spacer()
                            }
                            .presentationDetents([.fraction(0.5)]) // Sheet nimmt 50% des Bildschirms ein
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
                Text("Bestellen")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Picker("Farbe", selection: $selectedColor) {
                    ForEach(colors, id: \.self) { color in
                        Text(color).tag(color)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Picker("Größe", selection: $selectedSize) {
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
                
                Button("Bestellung zum Warenkorb abschicken") {
                    cartViewModel.addToCart(product, quantity: orderQuantity, color: selectedColor, size: selectedSize)
                    showOrderSheet = false
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                
                Spacer()
            }
            .presentationDetents([.fraction(0.5)]) // Sheet nimmt 50% des Bildschirms ein
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(product: Product(id: 1, title: "Sample Product", price: 29.99, description: "This is a sample product description.", category: "electronics", image: "https://via.placeholder.com/150"))
            .environmentObject(CartViewModel()) // Add environmentObject for preview
    }
}

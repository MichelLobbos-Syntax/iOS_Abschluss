//
//  CartView.swift
//  ios-abschluss
//
//  Created by Michel Lobbos on 15.06.24.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var cartViewModel: CartViewModel
    @Binding var profile: Profile
    @State private var showingSheet = false
    @Binding var selectedTab: Int
    @State private var isDeliveryViewPresented = false
    
    var body: some View {
        VStack {
            Text("Warenkorb")
                .font(.title)
            List {
                ForEach(cartViewModel.cartItems) { item in
                    VStack {
                        HStack {
                            AsyncImage(url: URL(string: item.product.image)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(10)
                                case .failure:
                                    Image(systemName: "exclamationmark.triangle")
                                        .foregroundColor(.red)
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(10)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            
                            VStack(alignment: .leading) {
                                Text(item.product.title)
                                    .font(.headline)
                                    .lineLimit(1) // Limit to one line
                                Text("Preis: \(item.product.price, specifier: "%.2f") €")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .lineLimit(1)
                                Text("Farbe: \(item.color)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .lineLimit(1)
                                Text("Größe: \(item.size)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .lineLimit(1)
                            }
                            Spacer()
                            HStack {
                                Button(action: {
                                    if item.quantity > 1 {
                                        cartViewModel.updateQuantity(item.product, quantity: item.quantity - 1, color: item.color, size: item.size)
                                    }
                                }) {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.blue)
                                }
                                .buttonStyle(.plain)
                                
                                Text("\(item.quantity)")
                                    .font(.headline)
                                    .padding(.horizontal)
                                
                                Button(action: {
                                    cartViewModel.updateQuantity(item.product, quantity: item.quantity + 1, color: item.color, size: item.size)
                                }) {
                                    Image(systemName: "plus.circle")
                                        .foregroundColor(.blue)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.vertical, 8) // Vertical padding for spacing between items
                        .fixedSize(horizontal: false, vertical: true) // Ensure each item has the same height
                        
                        Divider() // Divider between list items
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        let item = cartViewModel.cartItems[index]
                        cartViewModel.removeFromCart(item.product, color: item.color, size: item.size)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .frame(maxHeight: .infinity) // Ensure the List takes up all available height
            
            HStack {
                Text("""
                     Gesamt:
                     \(cartViewModel.totalCost(), specifier: "%.2f") €
                     """)
                .font(.headline)
                    .padding()
                Spacer()
                Button("Bestellen") {
                    showingSheet.toggle()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CartViewModel()
        viewModel.cartItems = [
            CartItem(product: Product(id: 1, title: "Sample Product 1", price: 29.99, description: "This is a sample product description.", category: "electronics", image: "https://via.placeholder.com/150"), quantity: 1, color: "Red", size: "M"),
            CartItem(product: Product(id: 2, title: "Sample Product 2 with Longer Title", price: 19.99, description: "Another sample product description.", category: "electronics", image: "https://via.placeholder.com/150"), quantity: 2, color: "Green", size: "L")
        ]
        let profile = Profile(
            name: "John",
            lastName: "Doe",
            email: "john.doe@example.com",
            birthDate: Date(),
            address: "123 Hauptstraße",
            city: "Irgendwo",
            postalCode: "12345",
            selectedPaymentMethod: "Kreditkarte",
            profileImageName: "profileImage"
        )
        
        return NavigationStack {
            CartView(cartViewModel: viewModel, profile: .constant(profile), selectedTab: .constant(0))
                .environmentObject(CartViewModel()) // Replace with your actual environment object
        }
    }
}

//
//  ProductCardView.swift
//  ios-abschluss
//
//  Created by Michel Lobbos on 11.06.24.
//

import SwiftUI

struct ProductCardView: View {
    let product: Product
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: product.image)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150) // Fixed height for the image
                } else if phase.error != nil {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150) // Fixed height for the placeholder
                        .foregroundColor(.gray)
                } else {
                    ProgressView()
                        .frame(height: 150) // Fixed height for the progress view
                }
            }
            .cornerRadius(10)
            
            Text(product.title)
                .font(.headline)
                .padding(.top, 5)
                .frame(maxWidth: .infinity, alignment: .leading) // Ensure text is aligned
            Text("\(product.price, specifier: "%.2f") €")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading) // Ensure text is aligned
        }
        .padding(.horizontal)
        .frame(width: 180, height: 250) // Fixed width and minimum height for the card
        .background(Color(.systemBackground)) // Use system background color
        .cornerRadius(10)
        .shadow(color: Color.gray, radius: 10, x: 5, y: 5) // Enhanced shadow for 3D effect
        .scaleEffect(0.95) // Slightly smaller scale for 3D effect
//        .rotation3DEffect(
//            Angle(degrees: 5),
//            axis: (x: 10.0, y: 10.0, z: 0.0)
//        ) // 3D rotation effect
    }
}

struct ProductCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProductCardView(product: Product(id: 1, title: "Sample Product", price: 29.99, description: "This is a sample product description.", category: "electronics", image: "https://via.placeholder.com/150"))
                .previewLayout(.sizeThatFits)
                .padding()
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .light)
            
            ProductCardView(product: Product(id: 1, title: "Sample Product", price: 29.99, description: "This is a sample product description.", category: "electronics", image: "https://via.placeholder.com/150"))
                .previewLayout(.sizeThatFits)
                .padding()
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
        }
    }
}

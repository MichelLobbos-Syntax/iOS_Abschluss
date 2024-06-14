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
        VStack(alignment: .leading, spacing: 10) {
            AsyncImage(url: URL(string: product.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 120)
                    .padding(.horizontal)
            } placeholder: {
                ProgressView()
                    .frame(height: 120)
                    .padding(.horizontal)
            }
            
            Text(product.title)
                .font(.headline)
                .foregroundColor(.primary)
            Text(product.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            HStack {
                Text("Price: \(product.price, specifier: "%.2f") €")
                    .font(.subheadline)
                    .foregroundColor(.primary)
                Spacer()
            }
        }
        .padding(10)
        .frame(height: 250)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.2), radius: 5)
    }
}

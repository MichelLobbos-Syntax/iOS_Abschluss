//
//  OrderItemView.swift
//  ios-abschluss
//
//  Created by Michel Lobbos on 20.06.24.
//

import SwiftUI

struct OrderItemView: View {
    let item: CartItem
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: URL(string: item.product.image)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .cornerRadius(8)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(8)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 80, height: 80)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.product.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                Text("Quantity: \(item.quantity)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("Price: \(item.price, specifier: "%.2f") €")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .padding(.trailing, 8)
            
            Spacer()
        }
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
    }
}

//
//  CartViewModel.swift
//  ios-abschluss
//
//  Created by Michel Lobbos on 15.06.24.
//

import Combine
import SwiftUI

class CartViewModel: ObservableObject {
    @Published var cartItems: [CartItem] = []

    func addToCart(_ product: Product, quantity: Int, color: String, size: String) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id && $0.color == color && $0.size == size }) {
            cartItems[index].quantity += quantity
        } else {
            let newItem = CartItem(product: product, quantity: quantity, color: color, size: size)
            cartItems.append(newItem)
        }
    }

    func updateQuantity(_ product: Product, quantity: Int, color: String, size: String) {
        if let index = cartItems.firstIndex(where: { $0.product.id == product.id && $0.color == color && $0.size == size }) {
            cartItems[index].quantity = quantity
        }
    }

    func removeFromCart(_ product: Product, color: String, size: String) {
        cartItems.removeAll { $0.product.id == product.id && $0.color == color && $0.size == size }
    }

    func totalCost() -> Double {
        cartItems.reduce(0) { $0 + $1.product.price * Double($1.quantity) }
    }
}

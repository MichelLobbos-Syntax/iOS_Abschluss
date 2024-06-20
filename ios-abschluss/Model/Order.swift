//
//  Order.swift
//  ios-abschluss
//
//  Created by Michel Lobbos on 20.06.24.
//

import Foundation

struct OrderModel: Identifiable {
    let id: UUID
    let date: Date
    let items: [CartItem]
    let totalPrice: Double
    
    // Helper method to calculate total price
    static func calculateTotalPrice(for items: [CartItem]) -> Double {
        items.reduce(0) { $0 + $1.price * Double($1.quantity) }
    }
}


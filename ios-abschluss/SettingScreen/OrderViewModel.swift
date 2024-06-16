//
//  OrderViewModel.swift
//  ios-abschluss
//
//  Created by Michel Lobbos on 16.06.24.
//

import Foundation
import Foundation

struct Order: Identifiable {
    var id: Int
    var date: Date
    var items: [OrderItem]
}

struct OrderItem: Identifiable {
    var id: Int
    var title: String
    var price: Double
    var quantity: Int
}

import SwiftUI

class OrdersViewModel: ObservableObject {
    @Published var orders: [Order] = []

    init() {
        // Beispielbestellungen hinzufügen
        orders = [
            Order(id: 1, date: Date(), items: [
                OrderItem(id: 1, title: "Produkt 1", price: 29.99, quantity: 1),
                OrderItem(id: 2, title: "Produkt 2", price: 19.99, quantity: 2)
            ]),
            Order(id: 2, date: Date(), items: [
                OrderItem(id: 3, title: "Produkt 3", price: 49.99, quantity: 1)
            ])
        ]
    }
}


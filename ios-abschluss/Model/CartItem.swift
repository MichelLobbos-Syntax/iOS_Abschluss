//
//  CartItem.swift
//  ios-abschluss
//
//  Created by Michel Lobbos on 15.06.24.
//

import Foundation

struct CartItem: Identifiable {
    let id = UUID()
    let product: Product
    var quantity: Int
    var color: String
    var size: String
}

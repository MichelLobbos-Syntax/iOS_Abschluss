//
//  Product.swift
//  ios-abschluss
//
//  Created by Michel Lobbos on 11.06.24.
//
//

import Foundation

struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    
}

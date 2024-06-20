//
//  OrdersViewModel.swift
//  ios-abschluss
//
//  Created by Michel Lobbos on 20.06.24.
//

import Foundation



import Foundation

class OrdersViewModel: ObservableObject {
    @Published var orders: [OrderModel] = []
    
    // Add a method to add orders
    func addOrder(_ order: OrderModel) {
            orders.append(order)
        }
    
}

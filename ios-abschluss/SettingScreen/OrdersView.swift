//
//  OrdersView.swift
//  ios-abschluss
//
//  Created by Michel Lobbos on 16.06.24.
//

import SwiftUI

struct OrdersView: View {
    @ObservedObject var ordersViewModel: OrdersViewModel
    
    var body: some View {
        List {
            ForEach(ordersViewModel.orders) { order in
                Section(header: Text("Bestellung \(order.id) - \(order.date, formatter: dateFormatter)")) {
                    ForEach(order.items) { item in
                        HStack {
                            Text(item.title)
                            Spacer()
                            Text("\(item.quantity) x \(item.price, specifier: "%.2f") €")
                        }
                    }
                }
            }
        }
        .navigationTitle("Bestellungen")
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()

//
//  OrdersView.swift
//  ios-abschluss
//
//  Created by Michel Lobbos on 20.06.24.
//

import SwiftUI

struct OrdersView: View {
    @EnvironmentObject var ordersViewModel: OrdersViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if ordersViewModel.orders.isEmpty {
                    Text("No orders yet.")
                        .font(.title)
                        .foregroundColor(.gray)
                } else {
                    List {
                        ForEach(ordersViewModel.orders) { order in
                            VStack(alignment: .leading) {
                                Text("Order ID: \(order.id.uuidString)")
                                    .font(.headline)
                                Text("Date: \(order.date, formatter: dateFormatter)")
                                    .font(.subheadline)
                                Text("Total Price: \(order.totalPrice, specifier: "%.2f") €")
                                    .font(.subheadline)
                                
                                ForEach(order.items) { item in
                                    HStack {
                                        Text(item.product.title)
                                        Spacer()
                                        Text("\(item.quantity) x \(item.price, specifier: "%.2f") €")
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
            .navigationTitle("Orders")
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            OrdersView()
                .environmentObject(OrdersViewModel())
        }
    }
}

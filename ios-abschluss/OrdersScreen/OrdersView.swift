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
        VStack{
            Text("Orders")
                .font(.largeTitle)
            
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(ordersViewModel.orders) { order in
                        OrderRowView(order: order)
                    }
                }
                .padding()
            }
        }
         
    }
}



//struct OrdersView_Previews: PreviewProvider {
//    static var previews: some View {
//        let sampleOrders = [
//            OrderModel(
//                id: UUID(),
//                date: Date(),
//                items: [
//                    CartItem(id: UUID(), product: Product(id: 1, title: "Sample Product 1", price: 29.99, description: "This is a sample product description.", category: "electronics", image: "https://via.placeholder.com/150"), quantity: 1, color: "Red", size: "M"),
//                    CartItem(id: UUID(), product: Product(id: 2, title: "Sample Product 2", price: 19.99, description: "Another sample product description.", category: "electronics", image: "https://via.placeholder.com/150"), quantity: 2, color: "Green", size: "L")
//                ],
//                totalPrice: 69.97
//            ),
//            OrderModel(
//                id: UUID(),
//                date: Date(),
//                items: [
//                    CartItem(id: UUID(), product: Product(id: 3, title: "Sample Product 3", price: 39.99, description: "This is a sample product description.", category: "electronics", image: "https://via.placeholder.com/150"), quantity: 1, color: "Blue", size: "S")
//                ],
//                totalPrice: 39.99
//            )
//        ]
//        
//        let ordersViewModel = OrdersViewModel()
//        ordersViewModel.orders = sampleOrders
//        
//        return NavigationStack {
//            OrdersView()
//                .environmentObject(ordersViewModel)
//        }
//    }
//}


//
//  SettingsView.swift
//  ios-abschluss
//
//  Created by Michel Lobbos on 16.06.24.
//

import SwiftUI

struct SettingsView: View {
    @Binding var profile: Profile
    @StateObject var ordersViewModel = OrdersViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination: ProfileView(profile: $profile)) {
                    HStack {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("Profile")
                    }
                }
                
                NavigationLink(destination: AddressView(profile: $profile)) {
                    HStack {
                        Image(systemName: "house")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("Delivery Address")
                    }
                }
                
                NavigationLink(destination: PaymentMethodView(profile: $profile)) {
                    HStack {
                        Image(systemName: "creditcard")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("Payment Method")
                    }
                }
                
//                NavigationLink(destination: OrdersView(ordersViewModel: ordersViewModel)) {
//                    HStack {
//                        Image(systemName: "bag")
//                            .resizable()
//                            .frame(width: 24, height: 24)
//                        Text("Bestellungen")
//                    }
//                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let profile = Profile(
            name: "John",
            lastName: "Doe",
            email: "john.doe@example.com",
            birthDate: Date(),
            address: "123 Main Street",
            city: "Somewhere",
            postalCode: "12345",
            selectedPaymentMethod: "Credit Card",
            profileImageName: "profileImage"
        )
        
        return SettingsView(profile: .constant(profile))
    }
}

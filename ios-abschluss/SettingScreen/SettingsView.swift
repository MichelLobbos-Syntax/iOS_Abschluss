//
//  SettingsView.swift
//  ios-abschluss
//
//  Created by Michel Lobbos on 16.06.24.
//

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
                Section(header: Text("Profile").font(.headline)) {
                    HStack {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                        NavigationLink(destination: ProfileView(profile: $profile)) {
                            Text("Profile")
                        }
                    }
                }
                
                Section(header: Text("Delivery Address").font(.headline)) {
                    HStack {
                        Image(systemName: "house")
                            .resizable()
                            .frame(width: 24, height: 24)
                        NavigationLink(destination: AddressView(profile: $profile)) {
                            Text("Delivery Address")
                        }
                    }
                }
                
                Section(header: Text("Payment Method").font(.headline)) {
                    HStack {
                        Image(systemName: "creditcard")
                            .resizable()
                            .frame(width: 24, height: 24)
                        NavigationLink(destination: PaymentMethodView(profile: $profile)) {
                            Text("Payment Method")
                        }
                    }
                }
                
                Section(header: Text("Bestellungen").font(.headline)) {
                    HStack {
                        Image(systemName: "bag")
                            .resizable()
                            .frame(width: 24, height: 24)
                        NavigationLink(destination: OrdersView(ordersViewModel: ordersViewModel)) {
                            Text("Bestellungen")
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .listStyle(InsetGroupedListStyle())
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

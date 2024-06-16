//
//  AddressView.swift
//  ios-abschluss
//
//  Created by Michel Lobbos on 16.06.24.
//

import SwiftUI

struct AddressView: View {
    @Binding var profile: Profile
    
    var body: some View {
        Form {
            Section(header: Text("Delivery Address")) {
                TextField("Address", text: $profile.address)
                TextField("City", text: $profile.city)
                TextField("Postal Code", text: $profile.postalCode)
            }
        }
        .navigationTitle("Delivery Address")
    }
}

struct AddressView_Previews: PreviewProvider {
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
        
        return NavigationStack {
            AddressView(profile: .constant(profile))
        }
    }
}


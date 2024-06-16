//
//  ProfileView.swift
//  ios-abschluss
//
//  Created by Michel Lobbos on 16.06.24.
//

import SwiftUI

struct ProfileView: View {
    @Binding var profile: Profile
    
    var body: some View {
        Form {
            Section(header: Text("Personal Information")) {
                TextField("First Name", text: $profile.name)
                TextField("Last Name", text: $profile.lastName)
                TextField("Email", text: $profile.email)
            }
            
            Section(header: Text("Profile Image")) {
                // You can add image picker functionality here
                Text("Profile Image Placeholder")
            }
        }
        .navigationTitle("Profile")
    }
}

struct ProfileView_Previews: PreviewProvider {
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
            ProfileView(profile: .constant(profile))
        }
    }
}

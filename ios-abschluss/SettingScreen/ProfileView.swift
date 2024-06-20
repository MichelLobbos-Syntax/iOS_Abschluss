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
        VStack {
            Form {
                Section(header: Text("Personal Information").font(.headline)) {
                    CustomTextField(placeholder: "First Name", text: $profile.name)
                    CustomTextField(placeholder: "Last Name", text: $profile.lastName)
                    CustomTextField(placeholder: "Email", text: $profile.email)
                }
            }
            
            Spacer()
            
            Button(action: saveProfile) {
                Text("Save")
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
        }
        .navigationTitle("Profile")
    }
    
    func saveProfile() {
        // Code to save profile changes
        print("Profile saved: \(profile)")
    }
}

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(placeholder)
                .font(.subheadline)
                .foregroundColor(.gray)
            TextField("", text: $text)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
        }
        .padding(.vertical, 5)
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

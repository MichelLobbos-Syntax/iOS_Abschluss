//
//  FilterButtonView.swift
//  ios-abschluss
//
//  Created by Michel Lobbos on 11.06.24.
//

import SwiftUI

struct FilterButtonView: View {
    let title: String
    @Binding var selectedCountry: String?
    let country: String?
    
    var body: some View {
        Button(action: {
            selectedCountry = country
        }) {
            
            Text(title)
                .padding()
                .fontWeight(selectedCountry == country ? .bold : .light)
                .background(selectedCountry == country ? Color.blue : Color.gray.opacity(0.2))
                .foregroundColor(selectedCountry == country ? .white : .black)
                .cornerRadius(8)
        }
    }
}

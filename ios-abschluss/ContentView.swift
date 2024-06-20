//
//  ContentView.swift
//  ios-abschluss
//
//  Created by Michel Lobbos on 10.06.24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var cartViewModel = CartViewModel()
    @StateObject private var ordersViewModel = OrdersViewModel()
    
    @State private var profile = Profile(
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
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Store", systemImage: "storefront")
                }
                .tag(0)
                .environmentObject(HomeViewModel())
                .environmentObject(cartViewModel)
                .environmentObject(FavoritesViewModel())
            
            CartView(cartViewModel: cartViewModel, profile: $profile, selectedTab: $selectedTab)
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
                .tag(1)
                .environmentObject(cartViewModel)
                .environmentObject(ordersViewModel)
                .badge(cartViewModel.cartItems.count > 0 ? String(cartViewModel.cartItems.count) : nil)
            
            
            OrdersView()
                .tabItem {
                    Label("Orders", systemImage: "list.bullet")
                }
                .tag(2)
                .environmentObject(ordersViewModel)
            
            SettingsView(profile: $profile)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(3)
            
            
        }
//                .preferredColorScheme(.dark) // Enable dark mode
    }
}

#Preview {
    ContentView()
}

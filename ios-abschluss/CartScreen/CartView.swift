//
//  CartView.swift
//  ios-abschluss
//
//  Created by Michel Lobbos on 15.06.24.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var cartViewModel: CartViewModel
    @EnvironmentObject var orderViewModel: OrdersViewModel
    @Binding var profile: Profile
    @Binding var selectedTab: Int
    @State private var showingSheet = false
    @State private var isDeliveryViewPresented = false

    var body: some View {
        VStack {
            Text("Warenkorb")
                .font(.title)
            List {
                ForEach(cartViewModel.cartItems) { item in
                    VStack {
                        HStack {
                            AsyncImage(url: URL(string: item.product.image)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(10)
                                case .failure:
                                    Image(systemName: "exclamationmark.triangle")
                                        .foregroundColor(.red)
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(10)
                                @unknown default:
                                    EmptyView()
                                }
                            }

                            VStack(alignment: .leading) {
                                Text(item.product.title)
                                    .font(.headline)
                                    .lineLimit(1)
                                Text("Preis: \(item.product.price, specifier: "%.2f") €")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .lineLimit(1)
                                Text("Farbe: \(item.color)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .lineLimit(1)
                                Text("Größe: \(item.size)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .lineLimit(1)
                            }
                            Spacer()
                            HStack {
                                Button(action: {
                                    if item.quantity > 1 {
                                        cartViewModel.updateQuantity(item.product, quantity: item.quantity - 1, color: item.color, size: item.size)
                                    }
                                }) {
                                    Image(systemName: "minus.circle")
                                        .foregroundColor(.blue)
                                }
                                .buttonStyle(.plain)

                                Text("\(item.quantity)")
                                    .font(.headline)
                                    .padding(.horizontal)

                                Button(action: {
                                    cartViewModel.updateQuantity(item.product, quantity: item.quantity + 1, color: item.color, size: item.size)
                                }) {
                                    Image(systemName: "plus.circle")
                                        .foregroundColor(.blue)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.vertical, 8)
                        .fixedSize(horizontal: false, vertical: true)

                        Divider()
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        let item = cartViewModel.cartItems[index]
                        cartViewModel.removeFromCart(item.product, color: item.color, size: item.size)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .frame(maxHeight: .infinity)

            HStack {
                Text("""
                     Gesamt:
                     \(cartViewModel.totalCost(), specifier: "%.2f") €
                     """)
                .font(.headline)
                .padding()
                Spacer()
                Button("Bestellen") {
                    showingSheet.toggle()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
        .sheet(isPresented: $showingSheet) {
            DeliveryView(
                cartViewModel: cartViewModel,
                orderViewModel: orderViewModel,
                profile: $profile
            )
        }
    }
}

struct DeliveryView: View {
    @ObservedObject var cartViewModel: CartViewModel
    @EnvironmentObject var orderViewModel: OrdersViewModel
    @Binding var profile: Profile

    @State private var deliveryAddress: String
    @State private var city: String
    @State private var postalCode: String
    @State private var paymentMethod: String
    @State private var firstName: String
    @State private var lastName: String
    @State private var email: String

    init(cartViewModel: CartViewModel, orderViewModel: OrdersViewModel, profile: Binding<Profile>) {
        self._cartViewModel = ObservedObject(wrappedValue: cartViewModel)
//        self._orderViewModel = EnvironmentObject(wrappedValue: orderViewModel)
        self._profile = profile

        // Initialize state variables with profile data
        self._deliveryAddress = State(initialValue: profile.wrappedValue.address)
        self._city = State(initialValue: profile.wrappedValue.city)
        self._postalCode = State(initialValue: profile.wrappedValue.postalCode)
        self._paymentMethod = State(initialValue: profile.wrappedValue.selectedPaymentMethod)
        self._firstName = State(initialValue: profile.wrappedValue.name)
        self._lastName = State(initialValue: profile.wrappedValue.lastName)
        self._email = State(initialValue: profile.wrappedValue.email)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Persönliche Informationen")) {
                    TextField("Vorname", text: $firstName)
                    TextField("Nachname", text: $lastName)
                    TextField("E-Mail", text: $email)
                        .keyboardType(.emailAddress)
                }

                Section(header: Text("Lieferadresse")) {
                    TextField("Adresse", text: $deliveryAddress)
                    TextField("Stadt", text: $city)
                    TextField("Postleitzahl", text: $postalCode)
                        .keyboardType(.numberPad)
                }

                Section(header: Text("Zahlungsmethode")) {
                    Picker("Zahlungsmethode", selection: $paymentMethod) {
                        Text("Kreditkarte").tag("Kreditkarte")
                        Text("PayPal").tag("PayPal")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section {
                    SwipeButton {
                        let newOrder = OrderModel(
                            id: UUID(),
                            date: Date(),
                            items: cartViewModel.cartItems,
                            totalPrice: cartViewModel.totalCost(),
                            customerName: "\(firstName) \(lastName)",
                            email: email,
                            address: deliveryAddress,
                            city: city,
                            postalCode: postalCode,
                            paymentMethod: paymentMethod
                        )
                        orderViewModel.addOrder(newOrder)
//                        cartViewModel.clearCart()
                        // Reset fields and close sheet
                        deliveryAddress = profile.address
                        city = profile.city
                        postalCode = profile.postalCode
                        paymentMethod = profile.selectedPaymentMethod
                        firstName = profile.name
                        lastName = profile.lastName
                        email = profile.email
                    }
                }
            }
            .navigationTitle("Lieferdetails")
            .navigationBarItems(trailing: Button("Abbrechen") {
                // Reset fields and close sheet
                deliveryAddress = profile.address
                city = profile.city
                postalCode = profile.postalCode
                paymentMethod = profile.selectedPaymentMethod
                firstName = profile.name
                lastName = profile.lastName
                email = profile.email
            })
        }
    }
}

struct SwipeButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            HStack {
                Spacer()
                Text("Bestätigen und Bestellen")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CartViewModel()

        viewModel.cartItems = [
            CartItem(product: Product(id: 1, title: "Sample Product 1", price: 29.99, description: "This is a sample product description.", category: "electronics", image: "https://via.placeholder.com/150"), quantity: 1, color: "Red", size: "M"),
            CartItem(product: Product(id: 2, title: "Sample Product 2 with Longer Title", price: 19.99, description: "Another sample product description.", category: "electronics", image: "https://via.placeholder.com/150"), quantity: 2, color: "Green", size: "L")
        ]
        let profile = Profile(
            name: "John",
            lastName: "Doe",
            email: "john.doe@example.com",
            birthDate: Date(),
            address: "123 Hauptstraße",
            city: "Irgendwo",
            postalCode: "12345",
            selectedPaymentMethod: "Kreditkarte",
            profileImageName: "profileImage"
        )

        return NavigationStack {
            CartView(cartViewModel: viewModel, profile: .constant(profile), selectedTab: .constant(0))
                .environmentObject(CartViewModel())
        }
    }
}

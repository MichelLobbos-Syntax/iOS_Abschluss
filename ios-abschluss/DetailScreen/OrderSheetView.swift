//
//  OrderSheetView.swift
//  ios-abschluss
//
//  Created by Michel Lobbos on 15.06.24.
//

import SwiftUI

struct OrderSheetView: View {
    let product: Product
    @Binding var selectedColor: Color?
    @Binding var selectedSize: String?
    @State private var orderQuantity: Int = 1
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("Bestellung")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // Farbauswahl
            if let selectedColor = selectedColor {
                Text("Farbe: \(selectedColor.description.capitalized)")
                    .foregroundColor(.secondary)
            }
            
            ColorSelectionView(colors: product.availableColors, selectedColor: $selectedColor)
            
            // Größenauswahl
            if let selectedSize = selectedSize {
                Text("Größe: \(selectedSize)")
                    .foregroundColor(.secondary)
            }
            
            SizeSelectionView(sizes: product.availableSizes, selectedSize: $selectedSize)
            
            // Bestellmenge
            HStack {
                Spacer()
                Button(action: {
                    if orderQuantity > 1 {
                        orderQuantity -= 1
                    }
                }) {
                    Image(systemName: "minus.circle")
                        .font(.title)
                        .foregroundColor(.blue)
                }
                Text("\(orderQuantity)")
                    .font(.title)
                    .padding(.horizontal)
                Button(action: {
                    orderQuantity += 1
                }) {
                    Image(systemName: "plus.circle")
                        .font(.title)
                        .foregroundColor(.blue)
                }
                Spacer()
            }
            .padding()
            
            // Bestellung abschicken Button
            Button("Zum Warenkorb hinzufügen") {
                // Hier können Sie die Bestellung zum Warenkorb hinzufügen oder andere Aktionen durchführen
                // z.B. cartViewModel.addToCart(product, color: selectedColor, size: selectedSize, quantity: orderQuantity)
                // Hier ist ein Beispiel, wie es aussehen könnte:
                print("Bestellung hinzugefügt: \(product.title), Farbe: \(selectedColor?.description ?? "Nicht ausgewählt"), Größe: \(selectedSize ?? "Nicht ausgewählt"), Menge: \(orderQuantity)")
                
                // Hier schließen wir das Sheet
                showOrderSheet = false
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(20)
            
            Spacer()
        }
        .padding()
        .presentation(isModal: true)
        .sheet(isPresented: $showOrderSheet)
    }
}

struct ColorSelectionView: View {
    let colors: [Color]
    @Binding var selectedColor: Color?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Farbe wählen:")
                .font(.headline)
                .foregroundColor(.secondary)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(colors, id: \.self) { color in
                        Button(action: {
                            selectedColor = color
                        }) {
                            Circle()
                                .fill(color)
                                .frame(width: 30, height: 30)
                                .overlay(
                                    Circle()
                                        .stroke(Color.white, lineWidth: selectedColor == color ? 2 : 0)
                                )
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.top, 10)
    }
}

struct SizeSelectionView: View {
    let sizes: [String]
    @Binding var selectedSize: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Größe wählen:")
                .font(.headline)
                .foregroundColor(.secondary)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(sizes, id: \.self) { size in
                        Button(action: {
                            selectedSize = size
                        }) {
                            Text(size)
                                .font(.body)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(selectedSize == size ? Color.blue : Color.gray, lineWidth: 1)
                                )
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.top, 10)
    }
}

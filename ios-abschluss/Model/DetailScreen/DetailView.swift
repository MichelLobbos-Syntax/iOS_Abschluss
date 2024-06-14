//
//  DetailView.swift
//  ios-abschluss
//
//  Created by Michel Lobbos on 11.06.24.
//

import SwiftUI

struct DetailView: View {
    let product: Product
    @State private var isFavorite: Bool = false
    @State private var showToast: Bool = false
    @State private var toastMessage: String = ""
    
    @State private var showOrderSheet: Bool = false
    @State private var orderQuantity: Int = 1
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: product.image)) { image in
                VStack {
                    image.resizable()
                        .scaledToFit()
                    .frame(height: 200)
                }
                .padding(.horizontal, 100)
                .background(.white)
            }
        placeholder: {
            ProgressView()
                .frame(height: 300)
        }
            VStack(alignment: .leading, spacing: 20){
                HStack{
                    Text(product.title)
                        .font(.headline)
                        .padding()
                    Spacer()
                    Button(action: {
    //                    if yerba.isAvailable {
    //                        showOrderSheet = true
                        }
    //                }
                    ) {
                        Image(systemName: "cart.badge.plus")
                            .resizable()
                            .frame(width: 40, height: 35)
    //                        .foregroundStyle(yerba.isAvailable ? .blue : .gray)
                    }
                    .frame(width: 50, height: 50)
                    .shadow(radius: 5)
                }
                
                HStack {
                    Text("Preis:")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text("\(product.price, specifier: "%.2f") €")
                        .font(.title2)
                        .foregroundStyle(.primary)
                }
                .padding(.vertical, 5)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Beschreibung:")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    
                    Text(product.description)
                        .font(.body)
                        .foregroundColor(.primary)
                }
                .padding(.top, 10)
            }
            .padding()
            
            
        }
        .navigationTitle(product.title)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(product: Product(id: 1, title: "Sample Product", price: 29.99, description: "This is a sample product description.", category: "electronics", image: "https://via.placeholder.com/150"))
    }
}

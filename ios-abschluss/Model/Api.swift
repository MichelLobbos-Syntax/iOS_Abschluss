//
//  Repo.swift
//  ios-abschluss
//
//  Created by Michel Lobbos on 11.06.24.
//

import Foundation
import Combine

class ApiService {
    static let shared = ApiService()

    func fetchProducts() -> AnyPublisher<[Product], Error> {
        let url = URL(string: "https://fakestoreapi.com/products")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Product].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

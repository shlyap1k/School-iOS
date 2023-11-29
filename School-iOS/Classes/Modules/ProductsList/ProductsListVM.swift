//
//  ProductsListVM.swift
//  School-iOS
//
//  Created by Shlyap1k on 29.11.2023.
//

import Factory
import Foundation
import SwiftUI

class ProductsListVM: ObservableObject {
    @Published var products: [Product] = []
    
    @Published var isLoading: Bool = false
    
    @Published var error: String = ""

    func fetchProducts() {
        isLoading = true
        let request = ProductRequest.productsList(pageNumber: 1, pageSize: 15)
        
        Task {
            let result: RestResult<[Product]> = await restProvider.make(request)
            switch result {
            case let .success(response):
                DispatchQueue.main.async {
                    self.products = response
                    self.isLoading = false
                }
            case let .failure(reason):
                DispatchQueue.main.async {
                    self.error = reason.detail.message
                    self.isLoading = false
                }
            }
        }
        
    }
    
    // MARK: Private

    @Injected(\.restProvider) private var restProvider
    @Injected(\.appState) private var appState
}

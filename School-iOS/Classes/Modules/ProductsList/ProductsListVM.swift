//
// HH School
// Created by Shlyap1k.
//

import Factory
import Foundation
import SwiftUI

class ProductsListVM: ObservableObject {
    // MARK: Internal

    @Published var products: [Product] = []

    @Published var isLoading: Bool = false

    @Published var error: String = ""

    @Published var lastPageReached: Bool = false

    func fetchProducts() {
        isLoading = true
        let request = ProductRequest.productsList(pageNumber: page, pageSize: 15)

        Task {
            let result: RestResult<[Product]> = await restProvider.make(request)
            switch result {
            case let .success(response):
                DispatchQueue.main.async {
                    if response.isEmpty {
                        self.lastPageReached = true
                    }
                    self.products += response
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

    func nextPage() {
        guard !lastPageReached else {
            return
        }
        page += 1
        fetchProducts()
    }

    // MARK: Private

    private var page: Int = 1
    @Injected(\.restProvider) private var restProvider
    @Injected(\.appState) private var appState
}

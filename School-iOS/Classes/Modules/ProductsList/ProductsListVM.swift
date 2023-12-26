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

    @Published var isEmpty: Bool = true

    @Published var placeholder: PlaceholderModel?

    var lastPageReached: Bool = false
    var page: Int = 0

    func fetchProducts() {
        isLoading = true
        let request = ProductRequest.productsList(pageNumber: page, pageSize: 15)

        Task {
            let result: RestResult<[Product]> = await restProvider.make(request)
            switch result {
            case let .success(response):
                DispatchQueue.main.async { [weak self] in
                    if response.isEmpty {
                        self?.lastPageReached = true
                    } else {
                        self?.isEmpty = false
                    }

                    self?.products += response

                    self?.placeholder = self?.products.count == 0 ? .emptyCatalog() : nil

                    self?.isLoading = false
                }
            case let .failure(reason):
                DispatchQueue.main.async { [weak weakSelf = self] in
                    guard let self = weakSelf else {
                        return
                    }
                    switch reason.detail {
                    case .noConnection:
                        weakSelf?.placeholder = .noConnection(isLoading: self.isLoadingBinding, action: {
                            weakSelf?.fetchProducts()
                        })
                    default:
                        weakSelf?.placeholder = .unknown(isLoading: self.isLoadingBinding, action: {
                            weakSelf?.fetchProducts()
                        })
                    }
                    weakSelf?.isLoading = false
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

    @Injected(\.restProvider) private var restProvider
    @Injected(\.appState) private var appState

    private var isLoadingBinding: Binding<Bool> {
        Binding<Bool>.init { [unowned self] in
            isLoading
        } set: { [unowned self] new in
            isLoading = new
        }
    }
}

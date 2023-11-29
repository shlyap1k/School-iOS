//
// HH School
// Created by Shlyap1k.
//

import Foundation

enum ProductRequest: Request {
    case productsList(pageNumber: Int, pageSize: Int)
    case addProduct(
        product: Product
    )
    case product(id: Int)

    // MARK: Internal

    var path: String {
        switch self {
        case let .product(id):
            return "products/\(id)"
        case .productsList:
            return "products"
        case .addProduct:
            return "product"
        }
    }

    var method: RestMethod {
        switch self {
        case .product, .productsList:
            return .get
        case .addProduct:
            return .post
        }
    }

    var body: Data? {
        switch self {
        case let .addProduct(product):
            return RequestDataEncoder.encode(product)
        case .product, .productsList:
            return nil
        }
    }

    var urlParameters: [URLQueryItem]? {
        switch self {
        case let .productsList(pageNumber, pageSize):
            return [
                URLQueryItem(name: "pageNumber", value: "\(pageNumber)"),
                URLQueryItem(name: "pageSize", value: "\(pageSize)"),
            ]
        case .product, .addProduct:
            return nil
        }
    }
}

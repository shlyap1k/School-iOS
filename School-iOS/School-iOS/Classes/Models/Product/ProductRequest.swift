//
//  ProductRequest.swift
//  School-iOS
//
//  Created by Shlyap1k on 23.11.2023.
//

import Foundation

enum ProductRequest: Request {
    case productsList(pageNumber: Int, pageSize: Int)
    case addProduct(
        title: String,
        department: String,
        price: Double,
        badge: [Badge],
        preview: String,
        images: [String],
        sizes: [Size],
        description: String,
        details: [String]
    )
    case products(id: Int)

    // MARK: Internal

    var path: String {
        switch self {
        case let .products(id):
            return "products/\(id)"
        case .productsList:
            return "products"
        case .addProduct:
            return "product"
        }
    }

    var method: RestMethod {
        switch self {
        case .products, .productsList:
            return .get
        case .addProduct:
            return .post
        }
    }

    var body: Data? {
        switch self {
        case let .addProduct(
            title,
            department,
            price,
            badge,
            preview,
            images,
            sizes,
            description,
            details
        ):
            return RequestDataEncoder.encode(
                Product(
                    title: title,
                    department: department,
                    price: price,
                    badge: badge,
                    preview: preview,
                    images: images,
                    sizes: sizes,
                    description: description,
                    details: details
                )
            )
        case .products, .productsList:
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
        case .products, .addProduct:
            return nil
        }
    }
}

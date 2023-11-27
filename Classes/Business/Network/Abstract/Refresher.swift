//
// HH School
// Created by Shlyap1k.
//

import Foundation

typealias AnyRefresher = any Refresher

// MARK: - Refresher

protocol Refresher: AnyObject {
    var unauthorized: Bool { get set }

    var refreshStrategy: RefreshStrategy { get }

    init(refreshStrategy: RefreshStrategy)

    var requestBuilder: RequestBuilder? { get set }

    var decoder: JSONDecoder? { get set }

    var session: URLSession? { get set }

    func refresh() async throws
}

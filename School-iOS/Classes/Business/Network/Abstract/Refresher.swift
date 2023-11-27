//
// HH School
// Copyright © 2023 Heads and Hands. All rights reserved.
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

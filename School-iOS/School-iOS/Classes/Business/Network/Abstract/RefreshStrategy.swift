//
// HH School
// Copyright © 2023 Heads and Hands. All rights reserved.
//

import Foundation

protocol RefreshStrategy {
    var refreshRequest: () -> Request? { get }
    var restParameters: RestParameters { get }

    var onRefresh: ((any Decodable) -> Void)? { get set }
    var onRefreshFailed: (() -> Void)? { get set }
}

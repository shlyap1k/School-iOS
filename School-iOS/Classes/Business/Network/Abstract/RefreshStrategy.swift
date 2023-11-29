//
// HH School
// Created by Shlyap1k.
//

import Foundation

protocol RefreshStrategy {
    var refreshRequest: () -> Request? { get }
    var restParameters: RestParameters { get }

    var onRefresh: ((any Decodable) -> Void)? { get set }
    var onRefreshFailed: (() -> Void)? { get set }
}

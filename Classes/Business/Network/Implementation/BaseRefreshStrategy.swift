//
// HH School
// Created by Shlyap1k.
//

import Foundation

struct BaseRefreshStrategy: RefreshStrategy {
    // MARK: Lifecycle

    init(
        refreshRequest: @escaping () -> Request?,
        restParameters: RestParameters,
        onRefresh: ((any Decodable) -> Void)?,
        onRefreshFailed: (() -> Void)?
    ) {
        self.refreshRequest = refreshRequest
        self.restParameters = restParameters
        self.onRefresh = onRefresh
        self.onRefreshFailed = onRefreshFailed
    }

    // MARK: Internal

    private(set) var refreshRequest: () -> Request?
    private(set) var restParameters: RestParameters
    var onRefresh: ((any Decodable) -> Void)?
    var onRefreshFailed: (() -> Void)?
}

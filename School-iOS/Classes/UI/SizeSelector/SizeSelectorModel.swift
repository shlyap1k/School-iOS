//
// HH School
// Created by Shlyap1k.
//

import Foundation

class SizeSelectorModel: ObservableObject {
    // MARK: Lifecycle

    init(sizes: [Size]) {
        self.sizes = sizes
    }

    // MARK: Internal

    var sizes: [Size] = []
    @Published var selectedSize: Size?
}

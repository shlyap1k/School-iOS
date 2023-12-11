//
// HH School
// Created by Shlyap1k.
//

import Foundation

class CountSelectorModel: ObservableObject {
    @Published var count: Int = 1
    @Published var desreaseEnabled: Bool = false

    func increase() {
        count += 1
        if count >= 2 {
            desreaseEnabled = true
        }
    }

    func decrease() {
        guard count >= 2 else {
            return
        }
        count -= 1
        if count < 2 {
            desreaseEnabled = false
        }
    }
}

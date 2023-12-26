//
// HH School
// Created by Shlyap1k.
//

import Foundation
import SwiftUI

class SnackerModel: ObservableObject {
    @Published var text: String = ""
    @Published var background: Color = .clear
    @Published var fontColor: Color = .white
    @Published var isPresented: Bool = false
}

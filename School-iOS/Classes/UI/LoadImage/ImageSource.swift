//
// HH School
// Created by Shlyap1k.
//

import Foundation
import SwiftUI

enum ImageSource {
    case remote(url: URL?)
    case local(name: String)
    case captured(image: UIImage)
}

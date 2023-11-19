//
// HH School
// Copyright © 2023 Heads and Hands. All rights reserved.
//

import Foundation

typealias RestResult<T> = Result<T, NetworkError> where T: Decodable

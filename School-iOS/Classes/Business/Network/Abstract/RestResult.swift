//
// HH School
// Created by Shlyap1k.
//

import Foundation

typealias RestResult<T> = Result<T, NetworkError> where T: Decodable

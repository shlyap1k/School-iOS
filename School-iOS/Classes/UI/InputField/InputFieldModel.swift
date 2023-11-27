//
//  InputFieldModel.swift
//  School-iOS
//
//  Created by Shlyap1k on 15.11.2023.
//

import Foundation

struct InputFieldModel {
    var text: String
    var error: String?
    var rule: (() -> Bool)?
}

//
//  Int.swift
//  Calculator_Prototype
//
//  Created by Nazarii Melnyk on 12/7/17.
//  Copyright © 2017 Nazarii Melnyk. All rights reserved.
//

import Foundation

extension Int {
    /// Returns formated value with comas as separators
    var withSeparators: String? {
        let format = NumberFormatter()
        format.numberStyle = .decimal
        
        return format.string(from: self as NSNumber)
    }
}

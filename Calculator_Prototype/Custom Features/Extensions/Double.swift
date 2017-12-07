//
//  Double.swift
//  Calculator_Prototype
//
//  Created by Nazarii Melnyk on 12/7/17.
//  Copyright © 2017 Nazarii Melnyk. All rights reserved.
//

import Foundation

extension Double {
    var isInteger: Bool {
        return self.truncatingRemainder(dividingBy: 1) == 0
    }
    
    /// Returns part of digit after coma
    var fractionalPart: Double {
        return self.truncatingRemainder(dividingBy: 1)
    }
    
    
    /// Returns formated value with comas as separators
    var withSeparators: String? {
        let format = NumberFormatter()
        format.numberStyle = .decimal
        format.maximumFractionDigits = String(self.fractionalPart).count
        
        return format.string(from: self as NSNumber)
    }
    
    /// Returns formatted value without fractional part, if it's integer, otherwise returns default value
    var asInteger: String? {
        return self.isInteger ?
            String(self).asInt :
            String(self)
    }
    
    /// Returns value in exponential view
    var asScientific: String? {
        let format = NumberFormatter()
        format.numberStyle = .scientific
        format.maximumFractionDigits = 6
        format.exponentSymbol = "e"
        
        return format.string(from: self as NSNumber)
    }
    
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

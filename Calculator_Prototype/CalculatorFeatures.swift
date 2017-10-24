//
//  CalculatorFeatures.swift
//  Calculator_Prototype
//
//  Created by Nazarii Melnyk on 10/9/17.
//  Copyright © 2017 Nazarii Melnyk. All rights reserved.
//

import Foundation
import UIKit

protocol OutputDelegate {
    var displayValue: String {get set}
}

extension Double {
    var isInteger: Bool {
        get { return self.truncatingRemainder(dividingBy: 1) == 0 }
    }
    
    /// Returns part of digit after coma
    var fractionalPart: Double {
        get { return self.truncatingRemainder(dividingBy: 1) }
    }
    
    
    /// Returns formated value with comas as separators
    var withSeparators: String? {
        get {
            let format = NumberFormatter()
            format.numberStyle = .decimal
            format.maximumFractionDigits = String(self.fractionalPart).count
            
            return format.string(from: self as NSNumber)
        }
    }
    
    /// Returns formatted value without fractional part, if it's integer, otherwise returns default value
    var asInteger: String? {
        get{
            return self.isInteger ?
                String(self).asInt :
                String(self)
        }
    }
    
    var asScientific: String? {
        get{
            let format = NumberFormatter()
            format.numberStyle = .scientific
            format.maximumFractionDigits = 6
            format.exponentSymbol = "e"
            
            return format.string(from: self as NSNumber)
        }
    }
    
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Int {
    /// Returns formated value with comas as separators
    var withSeparators: String? {
        get {
            let format = NumberFormatter()
            format.numberStyle = .decimal
            
            return format.string(from: self as NSNumber)
        }
    }
}

extension String {
    /// Finds and deletes all "," characters if they are
    var withoutSeparators: Double? {
        get{
            if self.range(of: ",") != nil{
                let collection = self.split(separator: ",")
                var result = ""
                
                for item in collection {
                    result += item
                }
                
                return result.toDouble()
            }
            return self.toDouble()
        }
    }
    
    var asInt: String? {
        get{
            if let dotIndex = self.index(of: "."){
                return String(self[self.startIndex ..< dotIndex])
            }
            return self
        }
    }
    
    /// Converts String to Double type without loss of accuracy
    func toDouble() -> Double? {
        let value = Double(self)
        
        if let dotIndex = self.index(of: "."){
            let beginFractional = self.index(after: dotIndex)
            if beginFractional != self.endIndex{
                let fractionalPart = self[beginFractional ..< self.endIndex]
                return value?.rounded(toPlaces: fractionalPart.count)
            }
        }
        
        return value
    }
    
    func addIndex(font: UIFont, range: NSRange) -> NSMutableAttributedString {
        let string = self
        let font = UIFont(name: "Helvetica", size:20)
        let fontSuper = UIFont(name: "Helvetica", size:10)
        
        
        
        let attString = NSMutableAttributedString(
            string: string,
            attributes: [NSAttributedStringKey.font:font!]
        )
        
        attString.setAttributes(
            [NSAttributedStringKey.font:fontSuper!, NSAttributedStringKey.baselineOffset:10],
            range: NSRange(location:8,length:2)
        )
        
        return attString
    }
    
}


/// Calculates factorial of integer(!) number of type Double
func factorial(of number: Double) -> Double {
    if number.isNaN { return Double.nan }
    if number > 999 { return Double.infinity}
        
    var product = 1.0
    
    for n in stride(from: number, to: 0, by: -1) {
        product *= n
    }
    
    return product
}


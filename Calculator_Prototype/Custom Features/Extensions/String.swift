//
//  String.swift
//  Calculator_Prototype
//
//  Created by Nazarii Melnyk on 12/7/17.
//  Copyright © 2017 Nazarii Melnyk. All rights reserved.
//

import Foundation
import UIKit

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
    
    /// Returns integer part of fractional value (all before dot)
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
    
    /// not finished...
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

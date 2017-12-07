//
//  CalculatorFeatures.swift
//  Calculator_Prototype
//
//  Created by Nazarii Melnyk on 10/9/17.
//  Copyright © 2017 Nazarii Melnyk. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

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

/// Plays system sound; sound's id: 1112
func playErrorSound(){
    AudioServicesPlaySystemSound(1112)
}


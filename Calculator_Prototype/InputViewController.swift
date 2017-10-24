//
//  InputView.swift
//  Calculator_Prototype
//
//  Created by Nazarii Melnyk on 10/5/17.
//  Copyright © 2017 Nazarii Melnyk. All rights reserved.
//

import UIKit

class InputView: UIView {
    
    private var isOnMiddleOfTyping = false
    
    private let brain = CalculatorBrain()
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let strDigit = sender.currentTitle!
        
        brain.wasTapped.digit = true
        
        if isOnMiddleOfTyping{
            stringValue += strDigit
        } else{
            stringValue = strDigit
            
            if doubleValue == 0 {
                return
            }
        }
        
        isOnMiddleOfTyping = true
    }
    
    @IBAction private func performOperation(_ sender: UIButton) {
        brain.setOperand(doubleValue)
        brain.performOperation(sender.currentTitle!)
        stringValue = String(brain.result)
        
        isOnMiddleOfTyping = false
    }
}

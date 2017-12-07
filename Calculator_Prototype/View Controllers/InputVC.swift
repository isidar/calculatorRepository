//
//  InputView.swift
//  Calculator_Prototype
//
//  Created by Nazarii Melnyk on 10/6/17.
//  Copyright © 2017 Nazarii Melnyk. All rights reserved.
//

import UIKit
import Foundation

class InputVC: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    var delegateToOutput: OutputDelegate?
    
    private var displayValue: String {
        get { return (delegateToOutput?.displayValue)! }
        set { delegateToOutput?.displayValue = newValue }
    }

    
    private var isOnMiddleOfTyping = false
    
    private let brain = CalculatorBrain()
    
    @IBAction private func touchDigit(_ sender: ButtonStyle) {
        sender.flashAnimation()
        
        let newDigit = sender.currentTitle!
        
        brain.wasTapped.digit = true
        
        if isOnMiddleOfTyping{
            let value: String
            
            if displayValue.range(of: ".") == nil {
                let newValue = (displayValue + newDigit).withoutSeparators!
                value = newValue.withSeparators!
            } else{
                value = displayValue + newDigit
            }
            
            if value.count <= 17 {
                displayValue = value
            } else{
                sender.shakeAnimation()
                playErrorSound()
            }
        } else{
            displayValue = newDigit
            if displayValue == "0" { return }
        }
        
        isOnMiddleOfTyping = true
    }
    
    @IBAction func touchDot(_ sender: ButtonStyle) {
        animateButton(sender)
        
        let displayStr = delegateToOutput!.displayValue
        
        if !isOnMiddleOfTyping {
            displayValue = "0."
        } else if displayStr.range(of: ".") == nil {
            displayValue += "."
        }
        isOnMiddleOfTyping = true
    }
    
    @IBAction func performOperation(_ sender: ButtonStyle) {
        brain.setOperand( displayValue.withoutSeparators ?? Double.nan )
        brain.performOperation(sender.currentTitle!)
        
        animateButton(sender)
        
        let result = brain.result
        var strValue = result.withSeparators!
        
        // cuts zero-fractional part
        strValue = result.isInteger ?
            strValue.asInt! :
        strValue

        // if string is bigger than 17 chars - convert to exponential view
        displayValue = strValue.count > 17 ?
            result.asScientific! :
        strValue
        
        isOnMiddleOfTyping = false
    }
    
    private func animateButton(_ button: ButtonStyle){
        if button.currentTitle == "MR" && brain.result == 0{
            button.shakeAnimation()
            playErrorSound()
        } else{
            button.flashAnimation()
        }
    }
}
    


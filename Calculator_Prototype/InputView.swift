//
//  InputView.swift
//  Calculator_Prototype
//
//  Created by Nazarii Melnyk on 10/6/17.
//  Copyright © 2017 Nazarii Melnyk. All rights reserved.
//

import UIKit
import Foundation

class InputView: UIViewController {
    /*
    override func viewDidLoad() {
        super.viewDidLoad()
        addIndexesToButtonNames()
        
    }*/
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var delegateToOutput: OutputDelegate?
    
    private var displayValue: String {
        get { return (delegateToOutput?.displayValue)! }
        set { delegateToOutput?.displayValue = newValue }
    }

    
    private var isOnMiddleOfTyping = false
    
    private let brain = CalculatorBrain()
    
    //fix that (I think..)
    @IBAction private func touchDigit(_ sender: UIButton) {
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
            
            displayValue = value.count <= 17 ? value : displayValue
        } else{
            displayValue = newDigit
            if displayValue == "0" { return }
        }
        
        isOnMiddleOfTyping = true
    }
    
    @IBAction func touchDot(_ sender: UIButton) {
        let displayStr = delegateToOutput!.displayValue
        
        if !isOnMiddleOfTyping {
            displayValue = "0."
        } else if displayStr.range(of: ".") == nil {
            displayValue += "."
        }
        isOnMiddleOfTyping = true
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        brain.setOperand( displayValue.withoutSeparators ?? Double.nan )
        brain.performOperation(sender.currentTitle!)
        let result = brain.result
        var strValue = result.withSeparators!
        
        // cuts zero-fractional part
        strValue = result.isInteger ?
            strValue.asInt! :
        strValue

        displayValue = strValue.count > 17 ?
            result.asScientific! :
        strValue
        
        isOnMiddleOfTyping = false
    }
}
    


//
//  ViewController.swift
//  Calculator_Prototype
//
//  Created by Nazarii Melnyk on 10/2/17.
//  Copyright © 2017 Nazarii Melnyk. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    var outputPlace: OutputView!
    var inputPlace: InputView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        switch segue.identifier! {
        case "input" :
            inputPlace = segue.destination as! InputView
        case "output" :
            outputPlace = segue.destination as! OutputView
        default: break
        }
        
        inputPlace?.delegateToOutput = outputPlace
    }
}

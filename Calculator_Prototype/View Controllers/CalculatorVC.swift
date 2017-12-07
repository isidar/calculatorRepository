//
//  ViewController.swift
//  Calculator_Prototype
//
//  Created by Nazarii Melnyk on 10/2/17.
//  Copyright © 2017 Nazarii Melnyk. All rights reserved.
//

import UIKit

class CalculatorVC: UIViewController {
    var outputPlace: OutputVC!
    var inputPlace: InputVC!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        switch segue.identifier! {
        case "input" :
            inputPlace = segue.destination as! InputVC
        case "output" :
            outputPlace = segue.destination as! OutputVC
        default: break
        }
        
        inputPlace?.delegateToOutput = outputPlace
    }
}

//
//  OutputView.swift
//  Calculator_Prototype
//
//  Created by Nazarii Melnyk on 10/6/17.
//  Copyright © 2017 Nazarii Melnyk. All rights reserved.
//

import UIKit

class OutputView: UIViewController, OutputDelegate {
    @IBOutlet private weak var resultLabel: UILabel!
    
    var displayValue: String {
        get { return (resultLabel?.text)! }
        set { resultLabel.text = newValue }
    }
}

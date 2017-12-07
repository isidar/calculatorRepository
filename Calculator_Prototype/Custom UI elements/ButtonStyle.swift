//
//  ButtonStyle.swift
//  Calculator_Prototype
//
//  Created by Nazarii Melnyk on 10/21/17.
//  Copyright © 2017 Nazarii Melnyk. All rights reserved.
//

import UIKit

@IBDesignable
class ButtonStyle: UIButton {   
    
    @IBInspectable
    var borderColor: UIColor? {
        get{
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set{
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get{
            return layer.borderWidth
        }
        set{
            layer.borderWidth = newValue
        }
    }
    
    func flashAnimation(){
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.05
        flash.fromValue = 1
        flash.toValue = 0.7
        flash.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 1
        
        layer.add(flash, forKey: nil)
    }
    
    func shakeAnimation(){
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 1
        shake.autoreverses = true
        let fromPoint = CGPoint(x: center.x - 5, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: center.x + 5, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        layer.add(shake, forKey: nil)
    }
}

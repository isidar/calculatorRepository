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
    /*
    @IBInspectable
    var addIndexes: Bool = true {
        didSet{
            self.addIndexesToButtonName()
            
        }
    }
    
    private func addIndexesToButtonName(){
        let buttonName = self.currentTitle
        let currentFont = self.titleLabel?.font
        
        if let flagChar = buttonName?.index(of: "^"){
            if let leftBrace = buttonName?.index(of: "("){
                if leftBrace == buttonName?.index(after: flagChar){
                    if let rightBrace = buttonName?.index(of: ")"){
                        if rightBrace > leftBrace{
                            self.setAttributedTitle(<#T##title: NSAttributedString?##NSAttributedString?#>, for: <#T##UIControlState#>) = buttonName?.addIndex(font: currentFont!, range:  NSRange.init(leftBrace...rightBrace, in: buttonName!))
                        }
                    }
                }
                
            }
            
            if let leftBrace = buttonName?.index(after: flagChar), leftBrace == "(",
                let rightBrace = buttonName?.index(after: flagChar) == ")"{
                
            }
            
            
            if
        }
        
        if buttonName
        
        self.titleLabel?.text = buttonName.addIndex(for: <#T##String#>, font: currentFont, range: <#T##NSRange#>)
        
        self.titleLabel?.font.pointSize
        
        self.titleLabel?.font =  UIFont(name: YourfontName, size: 20)
        
    }
    */
}

/*
public class MyButton: UIButton
{
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        updateCornerRadius()
    }
    
    @IBInspectable
    var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    func updateCornerRadius() {
        layer.cornerRadius = rounded ? frame.size.height / 2 : 0
    }
}
*/

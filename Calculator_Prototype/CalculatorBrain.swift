//
//  CalculatorBrain.swift
//  Calculator_Prototype
//
//  Created by Nazarii Melnyk on 10/2/17.
//  Copyright © 2017 Nazarii Melnyk. All rights reserved.
//

import Foundation

class CalculatorBrain{
    private var accumulator: Double = 0
    private var memoryStorage: Double = 0
    
    private struct PendingInfo{
        var firstOperand: Double
        var function: (Double, Double) -> Double
    }
    private var pending: PendingInfo?
    
    struct WasTapped {
        var equal: Bool
        var digit: Bool
    }
    var wasTapped = WasTapped(equal: false, digit: false)

    private enum Operation {
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equal
        case Clear
        case Constant(Double)
        case Memory
    }
    
    private var operations: Dictionary <String, Operation> = [
        "±" : .UnaryOperation( {-$0} ),
        "√" : .UnaryOperation(sqrt),
        "xˆ2" : .UnaryOperation( {$0 * $0} ),
        "xˆ3" : .UnaryOperation( {$0 * $0 * $0} ),
        "2^x" : .UnaryOperation( {pow(2,$0)} ),
        "10^x" : .UnaryOperation( {pow(10,$0)} ),
        "1/x" : .UnaryOperation( {1 / $0} ),
        "cos" : .UnaryOperation(cos),
        "sin" : .UnaryOperation(sin),
        "tg" : .UnaryOperation(tan),
        "ctg" : .UnaryOperation( {1/tan($0)} ),
        "ln" : .UnaryOperation(log),
        "log10" : .UnaryOperation(log10),
        "log2" : .UnaryOperation(log2),
        "!" : .UnaryOperation(factorial),
        
        "+" : .BinaryOperation( {$0 + $1} ),
        "-" : .BinaryOperation( {$0 - $1} ),
        "×" : .BinaryOperation( {$0 * $1} ),
        "/" : .BinaryOperation( {$0 / $1} ),
        "xˆy" : .BinaryOperation( {pow($0,$1)} ),
        "logx(y)" : .BinaryOperation({ log($1)/log($0) }),
        
        "=" : .Equal,
        "AC" : .Clear,
        "π" : .Constant(3.14159),
        "e" : .Constant(2.71828),
        "MC" : .Memory,
        "MR" : .Memory,
        "M+" : .Memory,
        "M-" : .Memory,
    ]
    
    var result: Double {
        return accumulator
    }
    
    func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation{
            case .UnaryOperation(let f) :
                accumulator = f(accumulator)
                wasTapped = WasTapped(equal: false, digit: false)
                
            case .BinaryOperation(let f) :
                if pending != nil && wasTapped.digit {
                    accumulator = pending!.function(pending!.firstOperand, accumulator)
                }
                pending = PendingInfo(firstOperand: accumulator, function: f) //always
                wasTapped.equal = false
                
            case .Equal:
                let tempAccumulatorValue = accumulator
                
                if pending != nil {
                    accumulator = wasTapped.equal ?
                        pending!.function(accumulator, pending!.firstOperand) :
                        pending!.function(pending!.firstOperand, accumulator)
                }
                if !wasTapped.equal {
                    pending?.firstOperand = tempAccumulatorValue
                }
                wasTapped.equal = true
                
            case .Clear:
                accumulator = 0.0
                pending = nil
            
            case .Constant(let n):
                accumulator = n
            
            case .Memory:
                switch symbol {
                case "MC" : memoryStorage = 0.0
                case "MR" : accumulator = memoryStorage
                case "M+" : memoryStorage += accumulator
                case "M-" : memoryStorage -= accumulator
                default : break
                }                
            }
        }
        
        wasTapped.digit = false
    }
}

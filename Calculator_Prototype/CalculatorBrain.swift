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
        //check all functions, especially "logs"
        "±" : Operation.UnaryOperation( {-$0} ),
        "√" : Operation.UnaryOperation(sqrt),
        "xˆ2" : Operation.UnaryOperation( {$0 * $0} ),
        "xˆ3" : Operation.UnaryOperation( {$0 * $0 * $0} ),
        "2^x" : Operation.UnaryOperation( {pow(2,$0)} ),
        "10^x" : Operation.UnaryOperation( {pow(10,$0)} ),
        "1/x" : Operation.UnaryOperation( {1 / $0} ),
        "cos" : Operation.UnaryOperation(cos),
        "sin" : Operation.UnaryOperation(sin),
        "tg" : Operation.UnaryOperation(tan),
        "ctg" : Operation.UnaryOperation( {1/tan($0)} ),
        "ln" : Operation.UnaryOperation(log),
        "log10" : Operation.UnaryOperation(log10),
        "log2" : Operation.UnaryOperation(log2),
        "!" : Operation.UnaryOperation(factorial),
        
        "+" : Operation.BinaryOperation( {$0 + $1} ),
        "-" : Operation.BinaryOperation( {$0 - $1} ),
        "×" : Operation.BinaryOperation( {$0 * $1} ),
        "/" : Operation.BinaryOperation( {$0 / $1} ),
        "xˆy" : Operation.BinaryOperation( {pow($0,$1)} ),
        "logx(y)" : Operation.BinaryOperation({ log($1)/log($0) }),
        
        "=" : Operation.Equal,
        
        "AC" : Operation.Clear,
        
        "π" : Operation.Constant(3.14159),
        "e" : Operation.Constant(2.71828),
        
        "MC" : Operation.Memory,
        "MR" : Operation.Memory,
        "M+" : Operation.Memory,
        "M-" : Operation.Memory,
    ]
    
    var result: Double {
        get { return accumulator }
    }
    
    func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation{
                
            case .UnaryOperation(let f) :
                accumulator = f(accumulator)
                //pending = nil
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
            
                // check if "digit was tapped" is needed
            case .Constant(let n):
                accumulator = n
            
                // check if "digit was tapped" is needed
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

//
//  CalculatorBrain.swift
//  Calculator_2.0
//
//  Created by haha on 16/5/8.
//  Copyright © 2016年 haha. All rights reserved.
//

// model file have nothing to do with UI NO UIKit import
import Foundation

// why put multiply outside the class? we want this function to be global not just a method in the class
func multiply(op1: Double, op2: Double) -> Double {
    return op1 * op2
}

class CalculatorBrain {
    
    private var accumulator = 0.0
    
    
    func setOperand( operand: Double) {
        accumulator = operand
    }
    
    // value should be sth work for a constant as well as a function so choose enum
    private var operations: Dictionary<String,Operation> = [
        "pi" : Operation.Constant(M_PI), //M_PI,
        "e" : Operation.Constant(M_E), // M_E
        "√" : Operation.UnaryOperation(sqrt), //sqrt use function name to refer to the functions no () required
        "cos" : Operation.UnaryOperation(cos), // cos
        "×" : Operation.BinaryOperation({$0 * $1}),
        "÷" : Operation.BinaryOperation({$0 / $1}),
        "+" : Operation.BinaryOperation({$0 + $1}),
        "-" : Operation.BinaryOperation({$0 - $1}),
        "=" : Operation.Equals
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
        
    }
    
    func performOperation(symbol: String) {
        
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator) // function and value are just local variables
            case .BinaryOperation(let function) :
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
         
            }
            
        }
    }
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
//        switch symbol {
//        case "pi": accumulator = M_PI
//        case "√": accumulator = sqrt(accumulator)
//        default: break
//        }
//        if let constant = operations[symbol] {
//            accumulator = constant
//        }
//        
//        let constant = operations[symbol]
//        accumulator = constant! // constant need unwrapping for the dictionary may not contain the symbol
    
    
    private var pending: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
}

//
//  ViewController.swift
//  Calculator_2.0
//
//  Created by haha on 16/5/4.
//  Copyright © 2016年 haha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet private weak var display: UILabel!
    private var userIsInTheMiddleOfTyping = false
    
    @IBAction private func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    private var displayValue: Double {
        get{
            return Double(display.text!)! // display.text String may not be converatable to Double 
        }
        set{
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()
    @IBAction private func performOperation(sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        
        displayValue = brain.result
    }
    
    
}


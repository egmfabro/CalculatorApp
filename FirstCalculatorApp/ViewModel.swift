//
//  ViewModel.swift
//  FirstCalculatorApp
//
//  Created by EFABRO on 4/10/26.
//

import Foundation
import UIKit

class CalculatorViewModel {
    var displayValue: String = "0"
    private var isFinalResult = false
    
    private var firstNumber: Double = 0
    private var currentOperation: String = ""
    private var isTypingNumber = false
    
    func receiveDigit (_ digit: String) {
        if displayValue == "0" || isFinalResult {
            displayValue = (digit == ".") ? "0." : digit
            isFinalResult = false
        } else {
            if digit == "." {
                let operators = CharacterSet(charactersIn: "+-×÷")
                let components = displayValue.components(separatedBy: operators)
                if let lastNumber = components.last, lastNumber.contains(".") {
                    return
                }
            }
            displayValue += digit
        }
    }
    
    func receiveOperation(_ operationSymbol: String) {
        isFinalResult = false
        if let lastChar = displayValue.last, "+-x÷".contains(lastChar) {
            displayValue.removeLast()
        }
        displayValue += operationSymbol
    }
    
    func calculatedResult() {
            if let lastChar = displayValue.last, "+-×÷".contains(lastChar) {
                displayValue.removeLast()
            }

            let formula = displayValue.replacingOccurrences(of: "×", with: "*")
                                      .replacingOccurrences(of: "÷", with: "/")
        
            let floatingPointFormula = "1.0 * \(formula)"
            let expression = NSExpression(format: floatingPointFormula)
            
            if let result = expression.expressionValue(with: nil, context: nil) as? Double {
                let formattedResult = String(format: "%.8f", result)
                displayValue = formatFinalString(formattedResult)
                isFinalResult = true
            }
        }
    
    func backspace() {
        if displayValue == "0" || isFinalResult { return }
        displayValue.removeLast()
        if displayValue.isEmpty {
            displayValue = "0"
        }
    }
    
    func clearAll() {
        displayValue = "0"
        isFinalResult = false
    }
    
    func getSymbol(from id: String) -> String {
            switch id {
            case "plus": return "+"
            case "minus": return "-"
            case "times": return "×"
            case "divided": return "÷"
            default: return ""
        }
    }
    
    private func formatFinalString(_ string: String) -> String {
        var result = string
        while result.contains(".") && (result.hasSuffix("0") || result.hasSuffix(".")) {
            result.removeLast()
        }
        return result
    }
}

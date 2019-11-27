//
//  Calculator.swift
//  CountOnMe
//
//  Created by Alexandre Goncalves on 14/10/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

/// This class is used to reckognize the elements choosen by the user and to do the operations requested by the user
final class Calculator {
    
    // MARK: - VARIABLES
    
    /// An array that will contain our operations
    var elements: [String] = []
    
    /// This variable is used to communicate with our controller
    weak var delegate: ShowAlertDelegate?
    
    /// A variable that is used to store the result of the different operations
    private var result: Double = 0
    
    /// Constant that represents the minimum number for an operation to be correct
    private let minElement = 3
    
    /// A variable that represents if the user is writting a decimal number or not
    private var isDecimal = false
    
    /// Check the number of items in the elements array
    private var expressionHaveEnoughElement: Bool {
        return elements.count >= minElement
    }
    
    /// Check if we can add an operand to the elements array
    private var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "/"
    }
    
    // MARK: - PRIVATE FUNCTIONS
    
    /// This method is used to check if we can add another dot for a decimal number
    ///
    /// - parameter array: An array of string wich contains our current operation
    /// - returns: `True` if we can add a decimal, `False` otherwise
    private func canAddDecimal(array: [String]) -> Bool {
        if let last = array.last {
            for chara in last where chara == "." {
                return false
            }
        }
        return true
    }
    
    /// This method is used to check if we can add a minus sign in our operation
    ///
    /// - parameter newOperator: The sign we  want to add to the expression
    /// - returns: `True` if the sign is a minus or if we can add an operator
    private func canAddMinus(newOperator: String ) -> Bool {
        if newOperator == "-" {
            return true
        }
        return elements.last != "+" && elements.last != "*" && elements.last != "/"
    }
    
    /// This method is used to check if the expression entered by the user have an equal sign
    ///
    /// - parameter text: A string wich contains our operation
    /// - returns: ' True ' if the expression have an equal sign
    private func expressionHaveResult(text: String) -> Bool {
        return text.firstIndex(of: "=") != nil
    }
    
    /// This method is used to convert our number in the string array into double. With this method we avoid he fact that the NSExpression returns only Int result even when working with divisions
    ///
    /// - parameter array: The array wich contains our expression
    /// - returns: An array with double number instead of Int numbers
    private func convertElementArray(array: [String]) -> [String] {
        var newArray = [String]()
        for element in array {
            if let decimal = Double(element) {
                newArray.append("\(decimal)")
            } else {
                newArray.append(element)
            }
        }
        return newArray
    }
    
    /// Perform the operation requested by the user
    private func performOperation() {
        let newElements = convertElementArray(array: elements)
        let newExpression = newElements.joined(separator: " ")
        let expression = NSExpression(format: newExpression)
        
        guard let resultat = expression.expressionValue(with: nil, context: nil) as? Double else { return }
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 3
        guard let value = formatter.string(from: NSNumber(value: resultat)) else { return }
        elements = []
        elements.insert(value, at: 0)
        
    }
    
    // - MARK: FUNCTIONS
    
    /// This method is used to split the text in parameter and add it to the elements array
    ///
    /// - parameter text: A string wich contains our operation
    func fillElementWith(text: String) {
        elements = text.split(separator: " ").map { "\($0)" }
    }
    
    /// Add a number to the expression if possible, otherwise notify the controller to show an alert
    ///
    /// - parameter number: The number to add
    func addNumber(number: String) {
        if expressionHaveResult(text: elements.joined(separator: " ")) {
            delegate?.showAlert(title: "Zero!", message: "Start a new Operation")
            delegate?.resetTextView()
            elements = []
        } else if isDecimal == false {
            delegate?.updateTextViewWith(text: "\(number)")
            elements.append(number)
        } else {
            if let last = elements.last {
                elements[elements.count - 1] = last + number
                delegate?.updateTextViewWith(text: "\(number)")
            }
        }
    }
    
    /// Add a dot to the expression if possible, otherwise notify the delegate to show an alert
    ///
    /// - parameter decimalText: The point for our decimal number
    func addDecimal(decimalText: String) {
        if expressionHaveResult(text: elements.joined(separator: " ")) {
            delegate?.showAlert(title: "Zero!", message: "Start a new operation")
            delegate?.resetTextView()
            elements = []
        } else if canAddDecimal(array: elements) == false {
            delegate?.showAlert(title: "Zero", message: "There is already a dot")
        } else {
            isDecimal = !isDecimal
            delegate?.updateTextViewWith(text: "\(decimalText)")
            if let last = elements.last {
                elements[elements.count - 1] = last + decimalText
            }
        }
    }
    
    /// Add an operator to the expression if possible otherwise notify the controller to show an alert
    ///
    /// - parameter newOperator: The operator we want to add to the expression
    func addOperator(newOperator: String) {
        if expressionHaveResult(text: elements.joined(separator: " ")) {
            delegate?.showAlert(title: "Zero!", message: "Start a new operation")
            delegate?.resetTextView()
            elements = []
        } else if canAddMinus(newOperator: newOperator) {
            isDecimal = !isDecimal
            delegate?.updateTextViewWith(text: " \(newOperator) ")
            elements.append(newOperator)
        } else {
            delegate?.showAlert(title: "Zero!", message: "There is already an operator")
        }
    }
    

    /// Add an equal sign into the expression and to perform the operation
    func addEqual() {
        if canAddOperator == false {
            delegate?.showAlert(title: "Zero!", message: "Expression is not correct")
        } else if expressionHaveEnoughElement == false {
            delegate?.showAlert(title: "Zero!", message: "Expression is not correct")
        } else {
            performOperation()
            if let first = elements.first {
                delegate?.updateTextViewWith(text: " = \(first)")
            }
            isDecimal = false
        }
    }
    
    /// Delete the last element of the array
    func deleteLastElement() {
        if !elements.isEmpty {
            elements.removeLast()
        }
    }
    
    func deleteAllElements() {
        if !elements.isEmpty {
            elements.removeAll()
        }
    }
}

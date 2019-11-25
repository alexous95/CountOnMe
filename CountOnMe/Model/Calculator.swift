//
//  Calculator.swift
//  CountOnMe
//
//  Created by Alexandre Goncalves on 14/10/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

/// This class is used to reckognize the elements choosen by the user and to do the operations requested by the user
public final class Calculator {
  
  // MARK: - VARIABLES
  
  /// An array that will contain our operations
  var elements: [String] = []
  
  /// A variable that is used to store the result of the different operations
  private var result: Double = 0
  
  /// A variable that is used to check if there is a division by zero
  private var dividedByZero: Bool = false
  
  /// Constant that represents the minimum number for an operation to be correct
  private let minElement = 3
  
  /// Check if the last element of the elements array is an operator
  var expressionIsCorrect: Bool {
    return elements.last != "+" &&
      elements.last != "-" &&
      elements.last != "*" &&
      elements.last != "/"
  }
  
  /// Check the number of items in the elements array
  var expressionHaveEnoughElement: Bool {
    return elements.count >= minElement
  }
  
  /// Check if we can add an operand to the elements array
  var canAddOperator: Bool {
    return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "/"
  }
  
  // MARK: - FUNCTIONS
  
  /// This method is used to split the text in parameter and add it to the elements array
  ///
  /// - parameter text: A string wich contains our operation
  func fillElementWith(text: String) {
    elements = text.split(separator: " ").map { "\($0)" }
  }
  
  /// This method is used to check if the expression entered by the user have an equal sign
  ///
  /// - parameter text: A string wich contains our operation
  /// - returns: ' True ' if the expression have an equal sign
  func expressionHaveResult(text: String) -> Bool {
    return text.firstIndex(of: "=") != nil
  }
  
  /// Check if there is a prioritary operator
  ///
  /// - Returns: A tuple with `True` and the position of the prioritary operator if there is a multiply or divide operator. Returns `False` and -1 if there is no prioritary expression
  func expressionPriority() -> (position: Int, isPresent: Bool) {
    var cmp = 0
    for element in elements {
      if element == "*" || element == "/" {
        return (position: cmp, isPresent: true)
      }
      cmp += 1
    }
    return (position: -1, isPresent: false)
  }
  
  /// Check if there is a division by 0
  ///
  /// - Parameter rightOperand: The denominator of the division
  ///
  /// - Returns: `True` if the denominator is equal to 0
  private func checkDivByZero(rightOperand: Double) -> Bool {
    if rightOperand == 0.0 {
      return true
    }
    return false
  }
  
  /// Perform a multiplication from the specified arguments
  ///
  /// - Parameters:
  ///   - operationArray: The array that is used to store the operation we want to perform
  ///   - position: The position of the priority operand
  ///
  /// - Returns: An array with the result at index position - 1 and the remaining operation if there are any
  private func performMultiplication(operationArray: [String], position: Int) -> [String] {
    var newArray = operationArray
    guard let left = Double(newArray[position - 1]) else { return [] }
    guard let right = Double(newArray[position + 1]) else { return [] }
    
    result = left * right
    
    for _ in position - 1...position + 1 {
      newArray.remove(at: position - 1)
    }
    
    newArray.insert("\(result)", at: position - 1)
    
    return newArray
  }
  
  /// Perform a division from the specified arguments
  ///
  /// - Parameters:
  ///   - operationArray: The array that is used to store the operation we want to perform
  ///   - position: The position of the priority operand
  ///
  /// - Returns: An array with the result at index position - 1 and the remaining operation if there are any. If there is a divison by zero the result is "Not a number"
  private func performDivision(operationArray: [String], position: Int) -> [String] {
    var newArray = operationArray
    guard let left = Double(newArray[position - 1]) else { return [] }
    guard let right = Double(newArray[position + 1]) else { return [] }
    
    if checkDivByZero(rightOperand: right) {
      dividedByZero = true
    }
    result = left / right
    
    for _ in position - 1...position + 1 {
      newArray.remove(at: position - 1)
    }
    
    if dividedByZero == true {
      newArray = []
      newArray.insert("Not a number", at: 0)
      dividedByZero = false
    } else {
      newArray.insert("\(result)", at: position - 1)
    }
    
    return newArray
  }
  
  /// This method is used to perform the operation requested by the user
  func performOperation() {
    var operationsToReduce = elements
    
    // Iterate over operations while an operand still here
    while operationsToReduce.count > 1 {
      let priorityOps = expressionPriority()
      
      // Case where there is a multiplication sign or division sign
      if priorityOps.isPresent {
        let operand = operationsToReduce[priorityOps.position]
        
        switch operand {
        case "*":
          operationsToReduce = performMultiplication(operationArray: operationsToReduce, position: priorityOps.position)
        case "/":
          operationsToReduce = performDivision(operationArray: operationsToReduce, position: priorityOps.position)
        default: return
        }
        
        elements = operationsToReduce
        
      } else {
        guard let left = Double(operationsToReduce[0]) else { return }
        let operand = operationsToReduce[1]
        guard let right = Double(operationsToReduce[2]) else { return }
        
        switch operand {
        case "+": result = left + right
        case "-": result = left - right
        default: return
        }
        
        operationsToReduce = Array(operationsToReduce.dropFirst(3))
        operationsToReduce.insert("\(result)", at: 0)
        elements = operationsToReduce
      }
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

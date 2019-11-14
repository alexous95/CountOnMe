//
//  Calculator.swift
//  CountOnMe
//
//  Created by Alexandre Goncalves on 14/10/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

/// This class is used to reckognize the elements choosen by the user and to do the operations requested by the user
public class Calculator {
  
  // MARK: - VARIABLES
  
  var elements: [String] = []
  private var result: Double = 0
  private var dividedByZero: Bool = false
  
  /// This computed property is used to check if the last element of the elements array is an operand
  var expressionIsCorrect: Bool {
    return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "/"
  }
  
  /// This computed property is used to check the number of items in the elements array
  var expressionHaveEnoughElement: Bool {
    return elements.count >= 3
  }
  
  /// This computed property is used to check if we can add an operand to the elements array
  var canAddOperator: Bool {
    return elements.last != "+" && elements.last != "-" && elements.last != "*" && elements.last != "/"
  }
  
  // MARK: - FUNCTIONS
  
  /// This method is used to split the text in parameter and add it to the elements array
  func fillElementWith(text: String) {
    elements = text.split(separator: " ").map { "\($0)" }
  }
  
  /// This method is used to check if the expression entered by the user have an equal sign
  func expressionHaveResult(text: String) -> Bool {
    return text.firstIndex(of: "=") != nil
  }
  
  /// This method is used to detect if a prioritary operand is present and return a tuple with the position of the priotary operand and true
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
  
  func checkDivByZero(rightOperand: Double) -> Bool {
    if rightOperand == 0.0 {
      return true
    }
    return false
  }
  
  /// This method is used to perform the operation requested by the user
  func performOperation() {
    var operationsToReduce = elements
    
    // Iterate over operations while an operand still here
    while operationsToReduce.count > 1 {
      let priorityOps = expressionPriority()
      
      // Case where there is a multiplication sign or division sign
      if priorityOps.isPresent {
        guard let left = Double(operationsToReduce[priorityOps.position - 1]) else { fatalError("Not a number") }
        let operand = operationsToReduce[priorityOps.position]
        guard let right = Double(operationsToReduce[priorityOps.position + 1]) else { fatalError("Not a number") }
        switch operand {
        case "*":
          result = left * right
        case "/":
          if checkDivByZero(rightOperand: right) {
            dividedByZero = true
          }
          result = left / right
        default: fatalError("unknown operator")
        }
        
        for _ in priorityOps.position - 1...priorityOps.position + 1 {
          operationsToReduce.remove(at: priorityOps.position - 1)
        }
        
        if !dividedByZero {
          operationsToReduce.insert("\(result)", at: priorityOps.position - 1)
          elements = operationsToReduce
        } else {
          operationsToReduce = []
          operationsToReduce.insert("Not a number", at: 0)
          elements = operationsToReduce
          dividedByZero = false
        }
        
      } else {
        guard let left = Double(operationsToReduce[0]) else { fatalError("Not a valid number") }
        let operand = operationsToReduce[1]
        guard let right = Double(operationsToReduce[2]) else { fatalError("Not a valid number") }
        
        switch operand {
        case "+": result = left + right
        case "-": result = left - right
        default: fatalError("Unknown operator !")
        }
        
        operationsToReduce = Array(operationsToReduce.dropFirst(3))
        operationsToReduce.insert("\(result)", at: 0)
        elements = operationsToReduce
      }
      
    }
  }
  
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

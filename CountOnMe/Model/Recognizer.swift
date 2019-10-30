//
//  Recognizer.swift
//  CountOnMe
//
//  Created by Alexandre Goncalves on 14/10/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

/// This class is used to reckognize the elements choosen by the user and to do the operations requested by the user
public class Recognizer {
  
  // MARK: - VARIABLES
  
  var elements: [String] = []
  var result: Double = 0
  
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
  
  /// This function is used to split the text in parameter and add it to the elements array
  func fillElementWith(text: String) {
    elements = text.split(separator: " ").map { "\($0)" }
  }
  
  /// This functions is used to check if the expression entered by the user have an equal sign
  func expressionHaveResult(text: String) -> Bool {
    return text.firstIndex(of: "=") != nil
  }
  
  /// This function is used to detect if a prioritary operand is present
  func expressionPriority() -> (Int, Bool) {
    var cmp = 0
    for element in elements {
      if element == "*" || element == "/" {
        return (cmp, true)
      }
      cmp += 1
    }
    return (-1, false)
  }
  
  /// This functions is used to perform the operation requested by the user
  func performOperation() {
    var operationsToReduce = elements
    
    // Iterate over operations while an operand still here
    while operationsToReduce.count > 1 {
      let priorityOps = expressionPriority()
      
      if priorityOps.1 {
        let left = Double(operationsToReduce[priorityOps.0 - 1])!
        let operand = operationsToReduce[priorityOps.0]
        let right = Double(operationsToReduce[priorityOps.0 + 1])!
        switch operand {
        case "*":
          result = left * right
        case "/":
          result = left / right
        default: fatalError("unknown operator")
        }
        
        for _ in priorityOps.0 - 1...priorityOps.0 + 1 {
          operationsToReduce.remove(at: priorityOps.0 - 1)
        }
        operationsToReduce.insert("\(result)", at: priorityOps.0 - 1)
        elements = operationsToReduce
        
      } else {
        let left = Double(operationsToReduce[0])!
        let operand = operationsToReduce[1]
        let right = Double(operationsToReduce[2])!
        
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
  
}

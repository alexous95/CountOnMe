//
//  Recognizer.swift
//  CountOnMe
//
//  Created by Alexandre Goncalves on 14/10/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation
import UIKit

public class Recognizer {
  
  var elements: [String] = []
  var result: Int = 0
  
  /// This computed property is used to check if the last element of the elements array is an operand
  var expressionIsCorrect: Bool {
    return elements.last != "+" && elements.last != "-"
  }
  
  /// This computed property is used to check the number of items in the elements array
  var expressionHaveEnoughElement: Bool {
    return elements.count >= 3
  }
  
  /// This computed property is used to check if we can add an operand to the elements array
  var canAddOperator: Bool {
    return elements.last != "+" && elements.last != "-"
  }
  
  /// This function is used to split the text in parameter and add it to the elements array
  func fillElementWith(text: String) {
    elements = text.split(separator: " ").map { "\($0)" }
  }
  
  /// This functions is used to check if the expression entered by the user have an equal sign
  func expressionHaveResult(text: String) -> Bool {
    return text.firstIndex(of: "=") != nil
  }
  
  func performOperation() {
    var operationsToReduce = elements
    
    // Iterate over operations while an operand still here
    while operationsToReduce.count > 1 {
      let left = Int(operationsToReduce[0])!
      let operand = operationsToReduce[1]
      let right = Int(operationsToReduce[2])!
      
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

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
  
}

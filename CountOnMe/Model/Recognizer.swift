//
//  Recognizer.swift
//  CountOnMe
//
//  Created by Alexandre Goncalves on 14/10/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

public class Recognizer {
  init() {}
  
  var elements : [String] = []
  
  var expressionIsCorrect: Bool {
    return elements.last != "+" && elements.last != "-"
  }
  
  var expressionHaveEnoughElement: Bool {
    return elements.count >= 3
  }
  
  var canAddOperator: Bool {
    return elements.last != "+" && elements.last != "-"
  }
  
  func fillElementWith(text : String) {
    elements = text.split(separator: " ").map { "\($0)" }
  }
  
  func expressionHaveResult(text : String) -> Bool {
    return text.firstIndex(of: "=") != nil
  }
  
}

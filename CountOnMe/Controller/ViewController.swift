//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var textView: UITextView!
  @IBOutlet var numberButtons: [UIButton]!
  
  var reckon = Recognizer()
  
  // View Life cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    updateReckon()
    // Do any additional setup after loading the view.
  }
  
  /// This function allows to update the string array from the model
  private func updateReckon() {
    reckon.fillElementWith(text: textView.text)
  }
  
  // View actions
  @IBAction func tappedNumberButton(_ sender: UIButton) {
    guard let numberText = sender.title(for: .normal) else {
      return
    }
    
    if reckon.expressionHaveResult(text: textView.text) {
      textView.text = ""
      updateReckon()
    }
    
    textView.text.append(numberText)
    updateReckon()
  }
  
  @IBAction func tappedAdditionButton(_ sender: UIButton) {
    if reckon.canAddOperator {
      textView.text.append(" + ")
      updateReckon()
    } else {
      showAlert(whitTitle: "Zero", message: "Un operateur est deja mis", actionTitle: "OK")
    }
  }
  
  @IBAction func tappedSubstractionButton(_ sender: UIButton) {
    if reckon.canAddOperator {
      textView.text.append(" - ")
      updateReckon()
    } else {
      showAlert(whitTitle: "Zero", message: "Un operateur est deja mis", actionTitle: "OK")
    }
  }
  
  @IBAction func tappedEqualButton(_ sender: UIButton) {
    guard reckon.expressionIsCorrect else {
      return showAlert(whitTitle: "Zéro!", message: "Entrez une expression correct", actionTitle: "Ok")
    }
    
    guard reckon.expressionHaveEnoughElement else {
      return showAlert(whitTitle: "Zéro!", message: "Demarrez un nouveau calcul", actionTitle: "Ok")
    }
    
    // Create local copy of operations
    var operationsToReduce = reckon.elements
    
    // Iterate over operations while an operand still here
    while operationsToReduce.count > 1 {
      let left = Int(operationsToReduce[0])!
      let operand = operationsToReduce[1]
      let right = Int(operationsToReduce[2])!
      
      let result: Int
      switch operand {
      case "+": result = left + right
      case "-": result = left - right
      default: fatalError("Unknown operator !")
      }
      
      operationsToReduce = Array(operationsToReduce.dropFirst(3))
      operationsToReduce.insert("\(result)", at: 0)
    }
    
    textView.text.append(" = \(operationsToReduce.first!)")
  }
  
}

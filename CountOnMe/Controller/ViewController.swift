//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // MARK: - OUTLET
  
  @IBOutlet weak var textView: UITextView!
  @IBOutlet var numberButtons: [UIButton]!
  @IBOutlet var operatorButtons: [UIButton]!
  @IBOutlet var deleteButton: UIButton!
  @IBOutlet var decimalButton: UIButton!
  
  var calculator = Calculator()
  
  // MARK: - VIEW LIFE CYCLE
  
  // View Life cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    
    textView.isEditable = false
    updateReckon()
  }
  
  // MARK: - PRIVATE FUNC
  
  /// This function allows to update the string array from the model
  private func updateReckon() {
    calculator.fillElementWith(text: textView.text)
  }
  
  // MARK: - ACTIONS
  
  /// This actions is called when a number button is pressed. It is used to update the textView and the model
  @IBAction func tappedNumberButton(_ sender: UIButton) {
    guard let numberText = sender.title(for: .normal) else {
      return
    }
    
    if calculator.expressionHaveResult(text: textView.text) {
      textView.text = ""
      updateReckon()
    }
    
    textView.text.append("\(numberText)")
    updateReckon()
  }
  
  /// This action is called when an operator buttons is pressed
  @IBAction func tappedOperatorButton(_ sender: UIButton) {
    guard let operatorText = sender.title(for: .normal) else {
      return
    }
    
    if calculator.expressionHaveResult(text: textView.text) {
      showAlertNewOperation()
      textView.text = ""
      updateReckon()
    } else if calculator.canAddOperator {
      textView.text.append(" \(operatorText) ")
      updateReckon()
    } else {
      showAlertOperand()
    }
    
  }
    
  /// This action is called when the equal button is pressed
  @IBAction func tappedEqualButton(_ sender: UIButton) {
    guard calculator.expressionIsCorrect else {
      return showAlertBadExpression()
    }
    
    guard calculator.expressionHaveEnoughElement else {
      return showAlertNewOperation()
    }
    
    calculator.performOperation()
    textView.text.append(" = \(calculator.elements.first!)")
  }
  
  @IBAction func tappedDeleteButton(_ sender: UIButton) {
    calculator.deleteLastElement()
    // The joined method allow us to create a String from an array of String using the separator we want between each string
    textView.text = calculator.elements.joined(separator: " ")
    textView.text.append(" ")
    updateReckon()
  }
  
  @IBAction func multipleTapDeleteButton() {
    calculator.deleteAllElements()
    textView.text = ""
    updateReckon()
  }
  
  @IBAction func decimalButtonTapped(_ sender: UIButton) {
    guard let decimalText = sender.title(for: .normal) else {
      return
    }
    
    if calculator.expressionHaveResult(text: textView.text) {
      showAlertNewOperation()
      textView.text = ""
      updateReckon()
    }
    
    textView.text.append("\(decimalText)")
    updateReckon()
  }
}

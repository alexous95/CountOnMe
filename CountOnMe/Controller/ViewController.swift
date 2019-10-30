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
  
  var reckon = Recognizer()
  
  // MARK: - VIEW LIFE CYCLE
  
  // View Life cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    updateReckon()
  }
  
  // MARK: - PRIVATE FUNC
  
  /// This function allows to update the string array from the model
  private func updateReckon() {
    reckon.fillElementWith(text: textView.text)
  }
  
  // MARK: - ACTIONS
  
  /// This actions is called when a number button is pressed. It is used to update the textView and the model
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
  
  /// This action is called when an operator buttons is pressed
  @IBAction func tappedOperatorButton(_ sender: UIButton) {
    guard let operatorText = sender.title(for: .normal) else {
      return
    }
    if reckon.expressionHaveResult(text: textView.text) {
      showAlertNewOperation()
      textView.text = ""
      updateReckon()
    } else if reckon.canAddOperator {
      textView.text.append(" \(operatorText) ")
      updateReckon()
    } else {
      showAlertOperand()
    }
    
  }
    
  /// This action is called when the equal button is pressed
  @IBAction func tappedEqualButton(_ sender: UIButton) {
    guard reckon.expressionIsCorrect else {
      return showAlertBadExpression()
    }
    
    guard reckon.expressionHaveEnoughElement else {
      return showAlertNewOperation()
    }
    
    reckon.performOperation()
    textView.text.append(" = \(reckon.elements.first!)")
  }
  
}

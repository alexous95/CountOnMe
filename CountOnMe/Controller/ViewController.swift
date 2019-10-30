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
    if reckon.expressionHaveResult(text: textView.text) {
      showAlertNewOperation()
      textView.text = ""
      updateReckon()
    } else if reckon.canAddOperator {
      textView.text.append(" + ")
      updateReckon()
    } else {
      showAlertOperand()
    }

  }
  
  @IBAction func tappedSubstractionButton(_ sender: UIButton) {
    if reckon.expressionHaveResult(text: textView.text) {
      showAlertNewOperation()
      textView.text = ""
      updateReckon()
    } else if reckon.canAddOperator {
      textView.text.append(" - ")
      updateReckon()
    } else {
      showAlertOperand()
    }
    
  }
  
  @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
    if reckon.expressionHaveResult(text: textView.text) {
      showAlertNewOperation()
      textView.text = ""
      updateReckon()
    } else if reckon.canAddOperator {
      textView.text.append(" * ")
      updateReckon()
    } else {
      showAlertOperand()
    }
    
  }
  
  @IBAction func tappedDivisionButton(_ sender: UIButton) {
    if reckon.expressionHaveResult(text: textView.text) {
      showAlertNewOperation()
      textView.text = ""
      updateReckon()
    } else if reckon.canAddOperator {
      textView.text.append(" / ")
      updateReckon()
    } else {
      showAlertOperand()
    }
    
  }
  
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

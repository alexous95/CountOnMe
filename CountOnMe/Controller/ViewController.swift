//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - OUTLET
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var operatorButtons: [UIButton]!
    @IBOutlet var deleteButton: UIButton!
    @IBOutlet var decimalButton: UIButton!
    
    /// An instance of our model which manage the data
    var calculator = Calculator()
    
    // MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculator.delegate = self
        textView.isEditable = false
    }
    
    // MARK: - PRIVATE FUNC
    
    /// Update the string array from the model
    private func updateCalculator() {
        calculator.fillElementWith(text: textView.text)
    }
    
    // MARK: - ACTIONS
    
    /// This actions is called when a number button is pressed. It is used to update the textView and the model
    ///
    /// - Parameter sender: The button that is pressed when the action is trigerred
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        
        updateCalculator()
        calculator.addNumber(numberText)
    }
    
    /// This action is called when an operator buttons is pressed
    ///
    /// - Parameter sender: The button that is pressed when the action is trigerred
    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        guard let operatorText = sender.title(for: .normal) else {
            return
        }
        updateCalculator()
        calculator.addOperator(operatorText)
      
    }
    
    /// This action is called when the equal button is pressed
    ///
    /// - Parameter sender: The button that is pressed when the action is trigerred
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        updateCalculator()
        calculator.addEqual()
        updateCalculator()
    }
    
    /// This action is called when the delete button is pressed
    ///
    /// - Parameter sender: The button that is pressed when the action is trigerred
    @IBAction func tappedDeleteButton(_ sender: UIButton) {
        calculator.deleteLastElement()
        // The joined method allow us to create a String from an array of String using the separator we want between each string
        textView.text = calculator.elements.joined(separator: " ")
        textView.text.append(" ")
        updateCalculator()
    }
    
    /// This action is called when the delete button is pressed
    @IBAction func multipleTapDeleteButton() {
        calculator.deleteAllElements()
        textView.text = ""
        updateCalculator()
    }
    
    /// This action is called when the decimal button is pressed
    ///
    /// - Parameter sender: The button that is pressed when the action is trigerred
    @IBAction func decimalButtonTapped(_ sender: UIButton) {
        guard let decimalText = sender.title(for: .normal) else {
            return
        }
        calculator.addDecimal(text: decimalText)
        updateCalculator()
    }
}

extension ViewController: ShowAlertDelegate {
    func updateTextView(with text: String) {
        textView.text.append(text)
    }
    
    func resetTextView() {
        textView.text = ""
    }
}

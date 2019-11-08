//
//  UIViewController+AlertAction.swift
//  CountOnMe
//
//  Created by Alexandre Goncalves on 18/10/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
  
  /// This method is used to present an AlertController when an operand is already choosen
  func showAlertOperand() {
    let alertController = UIAlertController(title: "Zero!", message: "An operand is already here", preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alertController.addAction(action)
    
    present(alertController, animated: true, completion: nil)
  }
  
  /// This method is used to present an AlertController when an expression is not correct
  func showAlertBadExpression() {
    let alertController = UIAlertController(title: "Zero!", message: "Enter a valid expression", preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alertController.addAction(action)
    
    present(alertController, animated: true, completion: nil)
  }
  
  /// This method is used to present an AlertController when there is no expression
  func showAlertNewOperation() {
    let alertController = UIAlertController(title: "Zero!", message: "Start a new operation", preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alertController.addAction(action)
    
    present(alertController, animated: true, completion: nil)
  }
}

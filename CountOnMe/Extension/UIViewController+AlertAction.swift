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
  
  /// This function is used to present an alertController with custom title, custom message and custom action as paramerters
  func showAlert(whitTitle title: String, message: String, actionTitle: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: actionTitle, style: .cancel, handler: nil)
    alertController.addAction(action)
    
    present(alertController, animated: true, completion: nil)
  }
  
  /// This method is used to present an AlertController when an operand is already choosen
  func showAlertOperand() {
    let alertController = UIAlertController(title: "Zéro!", message: "Un operateur est deja mis", preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alertController.addAction(action)
    
    present(alertController, animated: true, completion: nil)
  }
  
  /// This method is used to present an AlertController when an expression is not correct
  func showAlertBadExpression() {
    let alertController = UIAlertController(title: "Zéro!", message: "Entrez une expression correct", preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alertController.addAction(action)
    
    present(alertController, animated: true, completion: nil)
  }
  
  /// This method is used to present an AlertController when there is no expression
  func showAlertNewOperation() {
    let alertController = UIAlertController(title: "Zéro!", message: "Demarrez un nouveau calcul", preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alertController.addAction(action)
    
    present(alertController, animated: true, completion: nil)
  }
}

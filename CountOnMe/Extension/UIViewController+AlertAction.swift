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
  
  func showAlert(whitTitle title: String, message: String, actionTitle: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: actionTitle, style: .cancel, handler: nil)
    alertController.addAction(action)
    
    present(alertController, animated: true, completion: nil)
  }
}

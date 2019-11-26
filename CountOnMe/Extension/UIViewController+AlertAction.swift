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
    
    /// This method is used to present an AlertController whith custom messages and title
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }
    
}

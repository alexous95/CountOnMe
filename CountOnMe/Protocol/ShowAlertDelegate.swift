//
//  ShowAlertProtocol.swift
//  CountOnMe
//
//  Created by Alexandre Goncalves on 25/11/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import Foundation

protocol ShowAlertDelegate: class {
    func showAlert(title: String, message: String)
    func updateTextViewWith(text: String)
    func resetTextView()
}

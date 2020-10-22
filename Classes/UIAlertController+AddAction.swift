//
//  UIAlertController+AddAction.swift
//  bsuser
//
//  Created by Khoa Le on 18/10/2020.
//

import UIKit

extension UIAlertController {
    func addActions(_ actions: [UIAlertAction?]) {
        for anAction in actions {
            add(action: anAction)
        }
    }

    func add(action: UIAlertAction?) {
        if let action = action {
            addAction(action)
        }
    }
}

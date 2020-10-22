//
//  UIViewController+Alerts.swift
//  bsuser
//
//  Created by Khoa Le on 18/10/2020.
//

import UIKit

extension UIAlertController {
    static func configured(
        title: String? = nil,
        message: String? = nil,
        preferredStyle: UIAlertController.Style
    ) -> UIAlertController {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: preferredStyle
        )
//        alertController.view.tintColor = UIColor.fromHex("0366d6")
        return alertController
    }
}

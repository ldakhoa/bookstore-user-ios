//
//  Extensions+UIViewController.swift
//  bsuser
//
//  Created by Khoa Le on 13/12/2020.
//

import SwiftyJSON
import UIKit

extension UIViewController {
  func presentErrorAlert(with data: JSON) {
    let errMessage = data["message"].stringValue
    let alert = UIAlertController.configured(
      title: "Something wrong",
      message: errMessage,
      preferredStyle: .alert
    )
    alert.addAction(AlertAction.ok())
    present(alert, animated: true)
  }
}

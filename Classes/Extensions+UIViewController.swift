//
//  Extensions+UIViewController.swift
//  bsuser
//
//  Created by Khoa Le on 13/12/2020.
//

import JGProgressHUD
import SwiftyJSON
import UIKit

extension UIViewController {

  func presentErrorAlert(title: String = "Something wrong", with data: JSON) {
    let hud = JGProgressHUD(style: .dark)
    hud.dismiss()
    let errMessage = data["message"].stringValue
    let alert = UIAlertController.configured(
      title: title,
      message: errMessage,
      preferredStyle: .alert
    )
    alert.addAction(AlertAction.ok())
    present(alert, animated: true)
		return
  }
}

//
//  CartNotLoginController.swift
//  bsuser
//
//  Created by Khoa Le on 11/12/2020.
//

import UIKit

final class CartNotLoginController: UIViewController {
  let selectedIndex = 4

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction
  func didTappedLoginButton(_ sender: Any) {
    guard let vc = AppSetting.Storyboards.Registration.login as? LoginViewController else { return }
    present(vc, animated: true)
  }
}

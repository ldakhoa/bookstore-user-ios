//
//  OrderSuccessController.swift
//  bsuser
//
//  Created by Khoa Le on 30/10/2020.
//

import UIKit

// MARK: - OrderSuccessControllerDelegate

protocol OrderSuccessControllerDelegate: AnyObject {
  func didTappedContinueShoppingButton()
}

// MARK: - OrderSuccessController

final class OrderSuccessController: UIViewController {

  // MARK: Internal

  @IBOutlet weak var orderIdLabel: UILabel!
  var createdOrder: CreatedOrder?
  weak var delegate: OrderSuccessControllerDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "iBooks.com Thanks you"
    orderIdLabel.text = "#\(createdOrder?.order?.id ?? "")"
  }

  // MARK: Private

  @IBAction
  private func didTappedContinueShoppingButton(_: Any) {
    presentingViewController?.tabBarController?.selectedIndex = 0
    presentingViewController?.dismiss(animated: true) {
      self.delegate?.didTappedContinueShoppingButton()
    }
  }

  @IBAction
  private func didTappedMyOrder(_ sender: Any) {
    dismiss(animated: true) {
      let myOrderViewController = MyOrdersController()
      myOrderViewController.modalPresentationStyle = .fullScreen
      let navController = UINavigationController(rootViewController: myOrderViewController)
      navController.modalPresentationStyle = .fullScreen
      navController.setNavigationBarHidden(true, animated: false)
      self.present(navController, animated: true)
    }
  }

}

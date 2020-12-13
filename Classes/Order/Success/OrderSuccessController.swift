//
//  OrderSuccessController.swift
//  bsuser
//
//  Created by Khoa Le on 30/10/2020.
//

import UIKit

final class OrderSuccessController: UIViewController {

  // MARK: Internal

  @IBOutlet weak var orderIdLabel: UILabel!
  var createdOrder: CreatedOrder?

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "iBooks.com Thanks you"
    orderIdLabel.text = "\(createdOrder?.order?.id ?? 0)"
  }

  // MARK: Private

  @IBAction
  private func didTappedContinueShoppingButton(_: Any) {
    presentingViewController?.tabBarController?.selectedIndex = 0
    presentingViewController?.dismiss(animated: true)
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

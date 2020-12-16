//
//  OrderAddPaymentController.swift
//  bsuser
//
//  Created by Khoa Le on 30/10/2020.
//

import UIKit

// MARK: - OrderAddPaymentControllerDelegate

protocol OrderAddPaymentControllerDelegate: AnyObject {
  func didTappedNext()
}

// MARK: - OrderAddPaymentController

final class OrderAddPaymentController: UIViewController, OrderAddCardDetailsControllerDelegate {

  // MARK: Internal

  @IBOutlet var cardStackView: UIStackView!
  @IBOutlet var payPalStackView: UIStackView!
  var isTappedNext: Bool = false
  weak var delegate: OrderAddPaymentControllerDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()

    cardStackView.addGestureRecognizer(UITapGestureRecognizer(
      target: self,
      action: #selector(didTappedCardStackView)
    ))
    payPalStackView.addGestureRecognizer(UITapGestureRecognizer(
      target: self,
      action: #selector(didTappedPayPalStackView)
    ))
  }

  func didTappedNext() {
    dismiss(animated: true) {
      self.delegate?.didTappedNext()
    }
  }

  // MARK: Private

  @IBAction
  private func didTappedDismissButton(_: Any) {
    dismiss(animated: true)
  }

  @objc
  private func didTappedCardStackView() {
    guard let orderAddPaymentMethodVC = AppSetting.Storyboards.Order.orderAddPaymentMethodVC as? OrderAddCardDetailsController else { return }
    orderAddPaymentMethodVC.delegate = self
    navigationController?.pushViewController(orderAddPaymentMethodVC, animated: true)
  }

  @objc
  private func didTappedPayPalStackView() {
    let alert = UIAlertController.configured(
      title: "Sorry!",
      message: "Pay with PayPal is in development.",
      preferredStyle: .alert
    )
    alert.addAction(AlertAction.ok())
    present(alert, animated: true)
  }

}

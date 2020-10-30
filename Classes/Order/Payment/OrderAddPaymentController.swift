//
//  OrderAddPaymentController.swift
//  bsuser
//
//  Created by Khoa Le on 30/10/2020.
//

import UIKit

final class OrderAddPaymentController: UIViewController {

    // MARK: Internal

    @IBOutlet weak var cardStackView: UIStackView!
    @IBOutlet weak var payPalStackView: UIStackView!

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

    // MARK: Private

    @IBAction
    private func didTappedDismissButton(_ sender: Any) {
        dismiss(animated: true)
    }

    @objc
    private func didTappedCardStackView() {
        let orderAddPaymentMethodVC = AppSetting.Storyboards.Order.orderAddPaymentMethodVC
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

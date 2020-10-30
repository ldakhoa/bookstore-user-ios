//
//  OrderViewController.swift
//  bsuser
//
//  Created by Khoa Le on 30/10/2020.
//

import UIKit

final class OrderViewController: UIViewController {

    // MARK: Internal

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Private

    @IBAction
    private func didTappedDismissButton(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction
    private func didTappedPlaceYourOrderButton(_ sender: Any) {
        let orderSuccessController = AppSetting.Storyboards.Order.orderSuccessVC
        navigationController?.pushViewController(orderSuccessController, animated: true)
    }
}

//
//  OrderSuccessController.swift
//  bsuser
//
//  Created by Khoa Le on 30/10/2020.
//

import UIKit

final class OrderSuccessController: UIViewController {

    // MARK: Internal

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "iBooks.com Thanks you"
    }

    // MARK: Private

    @IBAction
    private func didTappedContinueShoppingButton(_: Any) {
        presentingViewController?.tabBarController?.selectedIndex = 0
        presentingViewController?.dismiss(animated: true)
    }
}

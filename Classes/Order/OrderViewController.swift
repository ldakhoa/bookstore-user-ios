//
//  OrderViewController.swift
//  bsuser
//
//  Created by Khoa Le on 30/10/2020.
//

import UIKit

final class OrderViewController: UIViewController {

    // MARK: Internal

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = Styles.Colors.background.color
        tableView.dataSource = self
        tableView.delegate = self
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

    @IBAction
    private func didTappedAddPaymentMethod(_ sender: Any) {

        let orderPaymentController = AppSetting.Storyboards.Order.orderAddPaymentVC
        let navController = UINavigationController(rootViewController: orderPaymentController)
        navController.setNavigationBarHidden(true, animated: true)
        present(navController, animated: true)

    }
}

// MARK: - UITableViewDataSource

extension OrderViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "OrderInformationCell",
                for: indexPath
            ) as? OrderInformationCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "OrderShippingAddressCell",
                for: indexPath
            ) as? OrderShippingAddressCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "OrderPaymentCell",
                for: indexPath
            ) as? OrderPaymentCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "OrderSubtotalCell",
                for: indexPath
            ) as? OrderSubtotalCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension OrderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 300
        case 1:
            return UITableView.automaticDimension
        case 2:
            return UITableView.automaticDimension
        case 3:
            return 100
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = Styles.Colors.background.color
        return view
    }
}

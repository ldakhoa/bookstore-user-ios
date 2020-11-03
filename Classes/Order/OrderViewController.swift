//
//  OrderViewController.swift
//  bsuser
//
//  Created by Khoa Le on 30/10/2020.
//

import UIKit

// MARK: - OrderViewController

final class OrderViewController: UIViewController {

  // MARK: Internal

  @IBOutlet var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.backgroundColor = Styles.Colors.background.color
    tableView.dataSource = self
    tableView.delegate = self
  }

  // MARK: Private

  @IBAction
  private func didTappedDismissButton(_: Any) {
    dismiss(animated: true)
  }

  @IBAction
  private func didTappedPlaceYourOrderButton(_: Any) {
    let orderSuccessController = AppSetting.Storyboards.Order.orderSuccessVC
    navigationController?.pushViewController(orderSuccessController, animated: true)
  }

  @IBAction
  private func didTappedAddPaymentMethod(_: Any) {
    let orderPaymentController = AppSetting.Storyboards.Order.orderAddPaymentVC
    let navController = UINavigationController(rootViewController: orderPaymentController)
    navController.setNavigationBarHidden(true, animated: true)
    present(navController, animated: true)
  }

  @objc
  private func didTappedEditAddressButton() {
    let editAddressVC = AppSetting.Storyboards.Order.editAddressVC
    navigationController?.pushViewController(editAddressVC, animated: true)
  }

  @objc
  private func didTappedEditOrderInfoButton() {
    dismiss(animated: true)
  }
}

// MARK: UITableViewDataSource

extension OrderViewController: UITableViewDataSource {
  func numberOfSections(in _: UITableView) -> Int {
    4
  }

  func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
    1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      guard let cell = tableView.dequeueReusableCell(
        withIdentifier: "OrderInformationCell",
        for: indexPath
      ) as? OrderInformationCell else { return UITableViewCell() }
      cell.selectionStyle = .none
      cell.editButton.addTarget(
        self,
        action: #selector(didTappedEditOrderInfoButton),
        for: .touchUpInside
      )
      return cell
    case 1:
      guard let cell = tableView.dequeueReusableCell(
        withIdentifier: "OrderShippingAddressCell",
        for: indexPath
      ) as? OrderShippingAddressCell else { return UITableViewCell() }
      cell.selectionStyle = .none
      cell.editButton.addTarget(
        self,
        action: #selector(didTappedEditAddressButton),
        for: .touchUpInside
      )
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

// MARK: UITableViewDelegate

extension OrderViewController: UITableViewDelegate {
  func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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

  func tableView(_: UITableView, estimatedHeightForRowAt _: IndexPath) -> CGFloat {
    200
  }

  func tableView(_: UITableView, heightForFooterInSection _: Int) -> CGFloat {
    8
  }

  func tableView(_: UITableView, viewForFooterInSection _: Int) -> UIView? {
    let view = UIView()
    view.backgroundColor = Styles.Colors.background.color
    return view
  }
}

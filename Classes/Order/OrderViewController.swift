//
//  OrderViewController.swift
//  bsuser
//
//  Created by Khoa Le on 30/10/2020.
//

import JGProgressHUD
import UIKit

// MARK: - OrderViewController

final class OrderViewController: UIViewController {

  // MARK: Internal

  @IBOutlet weak var totalPriceLabel: UILabel!
  @IBOutlet var tableView: UITableView!

  var createdOrder: CreatedOrder?
  let hud = JGProgressHUD(style: .dark)

  var cart: Cart?
  var user: User?

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.backgroundColor = Styles.Colors.background.color
    tableView.dataSource = self
    tableView.delegate = self

    totalPriceLabel.text = String(format: "$%.2f", cart?.totalPrice ?? 0)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    tableView.reloadData()
    fetchUserInfo()
  }

  // MARK: Private

  private func fetchUserInfo() {
    NetworkManagement.getInformationOfUser { code, data in
      if code == ResponseCode.ok.rawValue {
        self.user = User.parseData(json: data["user"])
        self.tableView.reloadData()
      } else {
        let errMessage = data["message"].stringValue
        let alert = UIAlertController.configured(
          title: "Something wrong",
          message: errMessage,
          preferredStyle: .alert
        )
        alert.addAction(AlertAction.ok())
        self.present(alert, animated: true)
      }
    }
  }

  @IBAction
  private func didTappedDismissButton(_: Any) {
    dismiss(animated: true)
  }

  @IBAction
  private func didTappedPlaceYourOrderButton(_: Any) {
    if user?.address?.count ?? 0 < 10 {
      let alert = UIAlertController(
        title: "Please fill your address",
        message: "We need your address and your phone number to ship your books",
        preferredStyle: .alert
      )
      alert.addAction(AlertAction.ok({ [weak self] _ in
        self?.didTappedEditAddressButton()
      }))
      present(alert, animated: true)
      return
    }
    hud.show(in: view)
    NetworkManagement.postPaymentOrder { code, data in
      if code == ResponseCode.ok.rawValue {
        self.createdOrder = CreatedOrder.parseData(json: data)
        guard let orderSuccessController = AppSetting.Storyboards.Order.orderSuccessVC as? OrderSuccessController else { return }
        orderSuccessController.createdOrder = self.createdOrder
        orderSuccessController.delegate = self
        orderSuccessController.modalPresentationStyle = .fullScreen
        self.present(orderSuccessController, animated: true, completion: nil)
        self.hud.dismiss()
      } else {
        let errMessage = data["message"].stringValue
        let alert = UIAlertController.configured(
          title: "Something wrong",
          message: errMessage,
          preferredStyle: .alert
        )
        alert.addAction(AlertAction.ok())
        self.present(alert, animated: true)

      }
    }
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
    guard let listOfAddressVC = AppSetting.Storyboards.Order.listOfAddressVC as? ListOfAddressController else { return }
    let navController = UINavigationController(rootViewController: listOfAddressVC)
    navController.setNavigationBarHidden(true, animated: true)
    navController.modalPresentationStyle = .fullScreen
    present(navController, animated: true)
  }

  @objc
  private func didTappedEditOrderInfoButton() {
    dismiss(animated: true)
  }
}

// MARK: UITableViewDataSource

extension OrderViewController: UITableViewDataSource {
  func numberOfSections(in _: UITableView) -> Int {
    3
  }

  func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
    1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      guard let cell = tableView.dequeueReusableCell(
        withIdentifier: "OrderShippingAddressCell",
        for: indexPath
      ) as? OrderShippingAddressCell else { return UITableViewCell() }
      cell.selectionStyle = .none

      cell.user = user
      cell.editButton.addTarget(
        self,
        action: #selector(didTappedEditAddressButton),
        for: .touchUpInside
      )
      return cell
    case 1:
      guard let cell = tableView.dequeueReusableCell(
        withIdentifier: "OrderPaymentCell",
        for: indexPath
      ) as? OrderPaymentCell else { return UITableViewCell() }
      cell.selectionStyle = .none
      return cell
    case 2:
      guard let cell = tableView.dequeueReusableCell(
        withIdentifier: "OrderSubtotalCell",
        for: indexPath
      ) as? OrderSubtotalCell else { return UITableViewCell() }
      cell.selectionStyle = .none
      cell.cart = cart
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
      return UITableView.automaticDimension
    case 1:
      return UITableView.automaticDimension
    case 2:
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

// MARK: OrderSuccessControllerDelegate

extension OrderViewController: OrderSuccessControllerDelegate {
  func didTappedContinueShoppingButton() {
    guard let referenceForTabBarController = presentingViewController as? MainTabBarController else { return }
    dismiss(animated: true) {
      referenceForTabBarController.selectedIndex = 2
    }
  }
}

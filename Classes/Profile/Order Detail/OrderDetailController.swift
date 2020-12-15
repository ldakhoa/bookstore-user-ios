//
//  OrderDetailController.swift
//  bsuser
//
//  Created by Khoa Le on 07/11/2020.
//

import JGProgressHUD
import UIKit

// MARK: - OrderDetailController

final class OrderDetailController: UIViewController {

  // MARK: Internal

  let hud = JGProgressHUD(style: .dark)

  @IBOutlet weak var leaveFeedbackButton: UIButton!
  @IBOutlet weak var tableView: UITableView!
  var order: Order?
  var orderID: String?

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Order Detail"
    navigationController?.navigationBar.prefersLargeTitles = false
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      image: #imageLiteral(resourceName: "back"),
      style: .plain,
      target: self,
      action: #selector(didTappedDismissButton)
    )
    navigationController?.navigationBar.barTintColor = Styles.Colors.White.normal
    navigationController?.navigationBar.titleTextAttributes = [.font: Styles.Text.bodyBold.preferredFont]

    leaveFeedbackButton.layer.borderWidth = 1
    leaveFeedbackButton.layer.borderColor = Styles.Colors.darkGreen.color.cgColor
    leaveFeedbackButton.addTarget(
      self,
      action: #selector(didTappedLeaveFeedbackButton),
      for: .touchUpInside
    )

    tableView.delegate = self
    tableView.dataSource = self
    tableView.backgroundColor = Styles.Colors.background.color

  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    fetchOrder()
  }

  // MARK: Private

  private func fetchOrder() {
    hud.show(in: view)
    NetworkManagement.getOrderBy(id: orderID ?? "") { code, data in
      if code == ResponseCode.ok.rawValue {
        self.order = Order.parseData(json: data["order"])
        self.tableView.reloadData()
        self.hud.dismiss()
      } else {
        self.presentErrorAlert(title: "Cannot get order", with: data)
      }
    }
  }

  @objc
  private func didTappedDismissButton() {
    navigationController?.popViewController(animated: true)
  }

  @objc
  private func didTappedLeaveFeedbackButton() {
    guard let vc = AppSetting.Storyboards.Profile.leaveFeedbackVC as? LeaveFeedbackController else { return }
    vc.book = order?.books[0]
    present(vc, animated: true)
  }

  @IBAction
  private func didTappedBuyAgainButton(_ sender: Any) {
    let bookDetailController = BookDetailController()
    bookDetailController.modalPresentationStyle = .fullScreen
    bookDetailController.book = order?.books[0]
    let navVC = UINavigationController(rootViewController: bookDetailController)
    navVC.modalPresentationStyle = .fullScreen
    present(navVC, animated: true)
  }

}

// MARK: UITableViewDataSource

extension OrderDetailController: UITableViewDataSource {

  // MARK: Internal

  func numberOfSections(in tableView: UITableView) -> Int {
    Sections.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case Sections.OrderNo.rawValue:
      guard let cell = tableView.dequeueReusableCell(
        withIdentifier: "OrderNoCell",
        for: indexPath
      ) as? OrderNoCell else { return UITableViewCell() }
      cell.order = order
      cell.selectionStyle = .none
      return cell
    case Sections.TrackingOrder.rawValue:
      guard let cell = tableView.dequeueReusableCell(
        withIdentifier: "TrackingOrderCell",
        for: indexPath
      ) as? TrackingOrderCell else { return UITableViewCell() }
      cell.order = order
      cell.selectionStyle = .none
      return cell
    case Sections.UserAddress.rawValue:
      guard let cell = tableView.dequeueReusableCell(
        withIdentifier: "ShippingAddressCell",
        for: indexPath
      ) as? ShippingAddressCell else { return UITableViewCell() }
      cell.order = order
      cell.selectionStyle = .none
      return cell
    case Sections.OrderInfo.rawValue:
      guard let cell = tableView.dequeueReusableCell(
        withIdentifier: "OrderDetailInformationCell",
        for: indexPath
      ) as? OrderDetailInformationCell else { return UITableViewCell() }
      cell.books = order?.books ?? []
      cell.layoutSubviews()
      cell.selectionStyle = .none
      return cell
    case Sections.PaymentMethod.rawValue:
      guard let cell = tableView.dequeueReusableCell(
        withIdentifier: "PaymentMethodCell",
        for: indexPath
      ) as? PaymentMethodCell else { return UITableViewCell() }
      cell.selectionStyle = .none
      return cell
    case Sections.TotalPrice.rawValue:
      guard let cell = tableView.dequeueReusableCell(
        withIdentifier: "TotalPriceCell",
        for: indexPath
      ) as? TotalPriceCell else { return UITableViewCell() }
      cell.order = order
      cell.selectionStyle = .none
      return cell
    default:
      Void()
    }
    return UITableViewCell()
  }

  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let view = UIView()
    view.backgroundColor = Styles.Colors.background.color
    return view
  }

  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    8
  }

  // MARK: Private

  private enum Sections: Int, CaseIterable {
    case OrderNo = 0
    case TrackingOrder = 1
    case UserAddress = 2
    case OrderInfo = 3
    case PaymentMethod = 4
    case TotalPrice = 5

    static let count = Sections.allCases.count
  }

}

// MARK: UITableViewDelegate

extension OrderDetailController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == Sections.OrderNo.rawValue {
      return 113
    } else if indexPath.section == Sections.OrderInfo.rawValue {
      //			return 200
      return UITableView.automaticDimension
    }

    return UITableView.automaticDimension
  }

  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    229
  }
}

//
//  BagViewController.swift
//  bsuser
//
//  Created by Khoa Le on 26/10/2020.
//

import UIKit

// MARK: - CartViewController

final class CartViewController: UIViewController {

  // MARK: Internal

  @IBOutlet var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Cart"
    navigationController?.navigationBar.prefersLargeTitles = false
    navigationController?.navigationBar.barTintColor = Styles.Colors.White.normal

    tableView.dataSource = self
    tableView.delegate = self
    tableView.backgroundColor = Styles.Colors.background.color
    tableView.separatorInset = .init(top: 0, left: 24, bottom: 0, right: 24)
    tableView.keyboardDismissMode = .interactive
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: animated)

    fetchCart()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  // MARK: Private

  private var cart: Cart?

  private func fetchCart() {
    NetworkManagement.getCartByUser(id: AppSecurity.shared.userID) { code, data in
      if code == ResponseCode.ok.rawValue {
        self.cart = Cart.parseData(json: data["cart"])
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
  private func didTappedCheckoutButton(_: Any) {
    let orderNavController = AppSetting.Storyboards.Order.orderNavController
    orderNavController.modalPresentationStyle = .fullScreen
    present(orderNavController, animated: true)
  }
}

// MARK: UITableViewDataSource

extension CartViewController: UITableViewDataSource {
  func numberOfSections(in _: UITableView) -> Int {
    2
  }

  func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
    section == 1 ? 1 : cart?.books.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      guard let cell = tableView.dequeueReusableCell(
        withIdentifier: "CartCell",
        for: indexPath
      ) as? CartCell else { return UITableViewCell() }
      let book = cart?.books[indexPath.row]
      cell.book = book
      cell.selectionStyle = .none
      return cell
    } else if indexPath.section == 1 {
      guard let cell = tableView.dequeueReusableCell(
        withIdentifier: "PromoCodeCell",
        for: indexPath
      ) as? PromoCodeCell else { return UITableViewCell() }
      cell.selectionStyle = .none
      return cell
    }

    return UITableViewCell()
  }
}

// MARK: UITableViewDelegate

extension CartViewController: UITableViewDelegate {
  func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    indexPath.section == 0 ? UITableView.automaticDimension : 100
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

//
//  BagViewController.swift
//  bsuser
//
//  Created by Khoa Le on 26/10/2020.
//

import JGProgressHUD
import UIKit

// MARK: - CartViewController

final class CartViewController: UIViewController {

  // MARK: Internal

  @IBOutlet weak var subtotalLabel: UILabel!
  @IBOutlet var tableView: UITableView!
  @IBOutlet weak var subtotalItemLabel: UILabel!
  @IBOutlet weak var bottomView: UIView!

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "Cart"
    navigationController?.navigationBar.prefersLargeTitles = false
    navigationController?.navigationBar.barTintColor = Styles.Colors.White.normal

    tableView.dataSource = self
    tableView.delegate = self
    tableView.backgroundColor = cart?.books.count ?? 0 > 0 ? Styles.Colors.background.color : Styles.Colors.White.normal
    tableView.separatorInset = .init(top: 0, left: 24, bottom: 0, right: 24)
    tableView.keyboardDismissMode = .interactive
    bottomView.isHidden = true
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: animated)

    fetchCart()
    fetchCartInfo()

  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  // MARK: Private

  private let hud = JGProgressHUD(style: .dark)

  private var cart: Cart?

  private var cartInfo: CartInfo? {
    didSet {
      let subtotal = cartInfo?.subtotalPrice ?? 0
      subtotalLabel.text = String(format: "$%.2f", subtotal)

      let itemText = cartInfo?.booksQuantity ?? 0 > 1 ? "items" : "item"
      subtotalItemLabel.text = "Subtotal (\(cartInfo?.booksQuantity ?? 0) \(itemText))"
    }
  }

  private func fetchCart() {
    hud.show(in: view)
    NetworkManagement.getCartByUser { code, data in
      if code == ResponseCode.ok.rawValue {
        self.cart = Cart.parseData(json: data["cart"])
        self.tableView.reloadData()
        self.hud.dismiss()
        self.bottomView.isHidden = self.cart?.books.count ?? 0 > 0 ? false : true
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

  private func fetchCartInfo() {
    hud.show(in: view)
    NetworkManagement.getCartInfoByUser { code, data in
      if code == ResponseCode.ok.rawValue {
        self.cartInfo = CartInfo.parseData(json: data)
        let tabBarVC = self.tabBarController as? MainTabBarController
        if let tabItems = tabBarVC?.tabBar.items {
          let tabItem = tabItems[2]
          if self.cartInfo?.booksQuantity ?? 0 <= 0 {
            tabItem.badgeValue = nil
          } else {
            tabItem.badgeValue = "\(self.cartInfo?.booksQuantity ?? 0)"
            tabBarVC?.repositionBadge()
          }
        }
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
  private func didTappedCheckoutButton(_: Any) {
    let orderNavController = AppSetting.Storyboards.Order.orderNavController
    orderNavController.modalPresentationStyle = .fullScreen
    present(orderNavController, animated: true)
  }
}

// MARK: UITableViewDataSource

extension CartViewController: UITableViewDataSource {
  func numberOfSections(in _: UITableView) -> Int {
    cart?.books.count ?? 0 > 0 ? 2 : 1
  }

  func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 1 {
      return cart?.books.count ?? 0 > 0 ? 1 : 0
    } else {
      return cart?.books.count ?? 0
    }
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
      cell.delegate = self
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

  // MARK: Internal

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UIView()

    let imageView = UIImageView(image: UIImage(named: "cart_placeholder"))
    imageView.contentMode = .scaleAspectFill

    let label = UILabel(
      text: "You have no books in your shopping cart",
      font: Styles.Text.body.preferredFont,
      textColor: Styles.Colors.black.color,
      textAlignment: .center,
      numberOfLines: 2
    )

    let button = UIButton(type: .system)
    button.setTitle("Continue shopping", for: .normal)
    button.setTitleColor(Styles.Colors.White.normal, for: .normal)
    button.backgroundColor = Styles.Colors.primary.color
    button.layer.cornerRadius = 8
    button.titleLabel?.font = Styles.Text.button.preferredFont

    headerView.addSubview(label)
    headerView.addSubview(imageView)
    headerView.addSubview(button)

    label.anchor(
      top: imageView.bottomAnchor,
      leading: headerView.leadingAnchor,
      bottom: nil,
      trailing: headerView.trailingAnchor,
      padding: .init(top: 8, left: 24, bottom: 0, right: 24)
    )

    imageView.anchor(
      top: headerView.topAnchor,
      leading: nil,
      bottom: nil,
      trailing: nil,
      padding: .init(top: 8, left: 0, bottom: 0, right: 0),
      size: .init(width: 250, height: 250)
    )
    imageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true

    button.anchor(
      top: label.bottomAnchor,
      leading: label.leadingAnchor,
      bottom: nil,
      trailing: label.trailingAnchor,
      padding: .init(top: 24, left: 0, bottom: 0, right: 0),
      size: .init(width: 0, height: 50)
    )
    button.addTarget(self, action: #selector(didTappedContinueShopping), for: .touchUpInside)

    return headerView
  }

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    cart?.books.count ?? 0 > 0 ? 0 : 400
  }

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
    view.backgroundColor = cart?.books.count ?? 0 > 0 ? Styles.Colors.background.color : Styles.Colors.White.normal
    return view
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let bookDetailController = BookDetailController()
    bookDetailController.modalPresentationStyle = .fullScreen
    bookDetailController.book = cart?.books[indexPath.row]
    let navVC = UINavigationController(rootViewController: bookDetailController)
    navVC.modalPresentationStyle = .fullScreen
    present(navVC, animated: true)
  }

  func tableView(
    _ tableView: UITableView,
    commit editingStyle: UITableViewCell.EditingStyle,
    forRowAt indexPath: IndexPath
  ) {
    if editingStyle == .delete {
      guard let bookId = cart?.books[indexPath.row].id else { return }
      hud.show(in: view)
      NetworkManagement.deleteCartWithBook(id: bookId) { code, data in
        if code == ResponseCode.ok.rawValue {
          self.cart?.books.remove(at: indexPath.row)
          self.tableView.deleteRows(at: [indexPath], with: .automatic)
          self.fetchCartInfo()
        } else {
          self.presentErrorAlert(title: "Cannot delete book", with: data)
        }
      }
    }
  }

  // MARK: Private

  @objc
  private func didTappedContinueShopping() {
    tabBarController?.selectedIndex = 0
  }

}

// MARK: CartCellDelegate

extension CartViewController: CartCellDelegate {
  func didTappedCancelButton(_ bookId: Int) {
    //
  }

  func didFinishedTapUpdateAmountButton() {
    hud.show(in: view)
  }

  func shouldDismissHUD() {
    fetchCartInfo()
  }

  func shouldShowError(_ errString: String) {
    let alert = UIAlertController.configured(
      title: "Something wrong",
      message: errString,
      preferredStyle: .alert
    )
    alert.addAction(AlertAction.ok())
    present(alert, animated: true) {
      self.hud.dismiss()
    }
  }
}

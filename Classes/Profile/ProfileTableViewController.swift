//
//  ProfileTableViewController.swift
//  bsuser
//
//  Created by Khoa Le on 11/10/2020.
//

import JGProgressHUD
import UIKit

final class ProfileTableViewController: UITableViewController {

  // MARK: Internal

  var user = User()
  let hud = JGProgressHUD(style: .dark)

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.backgroundColor = Styles.Colors.background.color
    tableView.tableFooterView = UIView()
    tableView.isScrollEnabled = false

    let nib = UINib(nibName: "ProfileCell", bundle: nil)

    tableView.register(nib, forCellReuseIdentifier: cellID)
    tabBarController?.tabBar.isHidden = true

    fetchUserInfo()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setNavigationBarHidden(false, animated: animated)
  }

  override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
    Sections.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? ProfileCell else { return UITableViewCell() }
    if indexPath.row == Sections.logout.rawValue {
      let logoutCell = LogoutCell(style: .default, reuseIdentifier: nil)
      return logoutCell
    } else {
      cell.titleLabel.text = datasource[indexPath.row]
    }

    return cell
  }

  override func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
    72
  }

  override func tableView(_: UITableView, viewForHeaderInSection _: Int) -> UIView? {
    let headerView = ProfileHeaderView()
    headerView.nameLabel.text = user.username.capitalizingFirstLetter()
    headerView.showProfileButton.addTarget(
      self,
      action: #selector(didTapShowProfile),
      for: .touchUpInside
    )
    return headerView
  }

  override func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
    100
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)

    switch indexPath.row {
    case Sections.orders.rawValue:
      let myOrderViewController = MyOrdersController()
      myOrderViewController.modalPresentationStyle = .fullScreen
      let navController = UINavigationController(rootViewController: myOrderViewController)
      navController.modalPresentationStyle = .fullScreen
      navController.setNavigationBarHidden(true, animated: false)
      present(navController, animated: true)
    case Sections.shippingAddress.rawValue:
      let listOfAddressVC = AppSetting.Storyboards.Order.listOfAddressVC
      let navController = UINavigationController(rootViewController: listOfAddressVC)
      navController.setNavigationBarHidden(true, animated: false)
      navController.modalPresentationStyle = .fullScreen
      present(navController, animated: true)
    case Sections.logout.rawValue:
      let alert = UIAlertController.configured(
        title: "Are you sure",
        message: "Are you sure you want to log out?",
        preferredStyle: .actionSheet
      )
      alert.addActions([
        AlertAction.cancel(),
        AlertAction(AlertActionBuilder {
          $0.title = "Log out"
          $0.style = .destructive
        }).get { [weak self] _ in
          self?.logout()
        },
      ])
      present(alert, animated: true)
    default:
      Void()
    }
  }

  // MARK: Private

  private enum Sections: Int, CaseIterable {
    case orders = 0
    case favorite = 1
    case shippingAddress = 2
    case paymentMethods = 3
    case reviews = 4
    case settings = 5
    case logout = 6

    // MARK: Internal

    static let count = Sections.allCases.count

    func getText() -> String {
      switch self {
      case .orders:
        return "My orders"
      case .favorite:
        return "My favorite"
      case .shippingAddress:
        return "Shipping addresses"
      case .paymentMethods:
        return "Payment methods"
      case .reviews:
        return "My reviews"
      case .settings:
        return "Settings"
      case .logout:
        return "Log out"
      }
    }
  }

  private let datasource: [String] = [
    "My orders",
    "My favorite",
    "Shipping addresses",
    "Payment methods",
    "My reviews",
    "Settings",
  ]

  private let cellID = "ProfileCell"

  private func logout() {
    AppSetting.shared.logout()
    AppSetting.shared.checkMainScreen()
  }

  @objc
  private func didTapShowProfile() {
    guard let editPersonalInfoController = AppSetting.Storyboards.Profile.editPersonalInfoVC as? EditPersonalInfoController else { return }
    editPersonalInfoController.user = user
    editPersonalInfoController.hidesBottomBarWhenPushed = true
    navigationController?.pushViewController(editPersonalInfoController, animated: true)
  }

  private func fetchUserInfo() {
    guard let userId = AppSecurity.shared.userID else { return }
    NetworkManagement.getInformationOfUserWith(id: userId) { code, data in
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
}

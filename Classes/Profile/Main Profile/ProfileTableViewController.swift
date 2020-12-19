//
//  ProfileTableViewController.swift
//  bsuser
//
//  Created by Khoa Le on 11/10/2020.
//

import JGProgressHUD
import SwiftyJSON
import UIKit

// MARK: - ProfileTableViewController

final class ProfileTableViewController: UITableViewController {

  // MARK: Internal

  var user: User?
  let hud = JGProgressHUD(style: .dark)
  var selectedImage: UIImage?
  var orders = [Order]()
  var favoriteBooks = [Book]()

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.backgroundColor = Styles.Colors.White.normal
    tableView.tableFooterView = UIView()
    tableView.isScrollEnabled = false

    let nib = UINib(nibName: "ProfileCell", bundle: nil)

    tableView.register(nib, forCellReuseIdentifier: cellID)
    tabBarController?.tabBar.isHidden = true

  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    fetchAllData()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setNavigationBarHidden(false, animated: animated)
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    1
  }

  override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
    5
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    switch indexPath.row {
    case Sections.orders.rawValue:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? ProfileCell else { return UITableViewCell() }
      let countText = orders.count > 1 ? "orders" : "order"
      cell.subtitleLabel.text = "Already have \(orders.count) \(countText)"
      cell.titleLabel?.text = Sections.orders.getText()
      return cell
    case Sections.favorite.rawValue:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? ProfileCell else { return UITableViewCell() }
      let countText = favoriteBooks.count > 1 ? "books" : "book"
      cell.subtitleLabel.text = "Already have \(favoriteBooks.count) \(countText)"
      cell.titleLabel?.text = Sections.favorite.getText()
      return cell
    case Sections.shippingAddress.rawValue:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? ProfileCell else { return UITableViewCell() }
      cell.titleLabel?.text = Sections.shippingAddress.getText()
      cell.subtitleLabel.removeFromSuperview()
      return cell
    case Sections.reviews.rawValue:
      guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? ProfileCell else { return UITableViewCell() }
      cell.titleLabel?.text = Sections.reviews.getText()
      cell.subtitleLabel.removeFromSuperview()
      return cell
    case Sections.logout.rawValue:
      let logoutCell = LogoutCell(style: .default, reuseIdentifier: nil)
      return logoutCell
    default:
      return UITableViewCell()
    }
  }

  override func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
    72
  }

  override func tableView(_: UITableView, viewForHeaderInSection _: Int) -> UIView? {
    let headerView = ProfileHeaderView()
    headerView.nameLabel.text = user?.username.capitalizingFirstLetter()
    headerView.profileImageView.addGestureRecognizer(UITapGestureRecognizer(
      target: self,
      action: #selector(didTappedProfileImageView)
    ))
    headerView.profileImageView.isUserInteractionEnabled = true
    if let url = URL(string: user?.profileImageUrl ?? "") {
      headerView.profileImageView.sd_setImage(with: url)
    }
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
      guard let listOfAddressVC = AppSetting.Storyboards.Order.listOfAddressVC as? ListOfAddressController else { return }
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
    case Sections.favorite.rawValue:
      guard let vc = AppSetting.Storyboards.Profile.myFavoriteVC as? MyFavoriteController else { return }
      vc.books = favoriteBooks
      navigationController?.pushViewController(vc, animated: true)
    case Sections.reviews.rawValue:
      let vc = AppSetting.Storyboards.Profile.myReviewsVC
      navigationController?.pushViewController(vc, animated: true)
    default:
      Void()
    }
  }

  // MARK: Private

  private enum Sections: Int, CaseIterable {
    case orders = 0
    case favorite = 1
    case shippingAddress = 2
    case reviews = 3
    case logout = 4

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
      case .reviews:
        return "My reviews"
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
  ]

  private let cellID = "ProfileCell"

  @objc
  private func didTappedProfileImageView() {
    let alert = UIAlertController.configured(preferredStyle: .actionSheet)
    alert.addActions([
      AlertAction.cancel(),
      AlertAction(AlertActionBuilder {
        $0.title = "Capture photo from camera"
        $0.style = .default
      }).get { [weak self] _ in
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
          let imagePickerController = UIImagePickerController()
          imagePickerController.delegate = self
          imagePickerController.sourceType = .camera
          self?.present(imagePickerController, animated: true)
        }
      },
      AlertAction(AlertActionBuilder {
        $0.title = "Select photo from gallery"
        $0.style = .default
      }).get { [weak self] _ in
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
          let imagePickerController = UIImagePickerController()
          imagePickerController.delegate = self
          imagePickerController.sourceType = .photoLibrary
          self?.present(imagePickerController, animated: true)
        }
      },
    ])
    present(alert, animated: true)

  }

  private func logout() {
    AppSetting.shared.logout()
    AppSetting.shared.getMainController()
  }

  @objc
  private func didTapShowProfile() {
    guard let editPersonalInfoController = AppSetting.Storyboards.Profile.editPersonalInfoVC as? EditPersonalInfoController else { return }
    editPersonalInfoController.user = user
    editPersonalInfoController.hidesBottomBarWhenPushed = true
    navigationController?.pushViewController(editPersonalInfoController, animated: true)
  }

  private func fetchAllData() {
    let dispatchGroup = DispatchGroup()
    hud.indicatorView = JGProgressHUDIndeterminateIndicatorView()
    hud.textLabel.text = ""
    hud.show(in: view)

    dispatchGroup.enter()
    NetworkManagement.getAllOrders { code, data in
      if code == ResponseCode.ok.rawValue {
        self.orders = Order.parseAllOrders(json: data)
        dispatchGroup.leave()
      } else {
        self.presentErrorAlert(title: "Cannot get orders", with: data)
        return
      }
    }

    dispatchGroup.enter()
    NetworkManagement.getAllFavorBooks { code, data in
      if code == ResponseCode.ok.rawValue {
        let books = Book.parseData(json: data)
        self.favoriteBooks = books
        dispatchGroup.leave()
      } else {
        self.presentErrorAlert(title: "Cannot get favorite books", with: data)
        return
      }
    }

    dispatchGroup.enter()
    NetworkManagement.getInformationOfUser { code, data in
      if code == ResponseCode.ok.rawValue {
        self.user = User.parseData(json: data["user"])
        dispatchGroup.leave()
      } else {
        let errMessage = data["message"].stringValue
        let alert = UIAlertController.configured(
          title: "Something wrong",
          message: errMessage,
          preferredStyle: .alert
        )
        alert.addAction(AlertAction.ok())
        self.present(alert, animated: true)
        return
      }
    }

    dispatchGroup.notify(queue: .main) {
      self.tableView.reloadData()
      self.hud.dismiss()
    }

  }

  private func fetchOrder() {
    hud.show(in: view)
    NetworkManagement.getAllOrders { code, data in
      if code == ResponseCode.ok.rawValue {
        self.orders = Order.parseAllOrders(json: data)
        self.tableView.reloadData()
        self.hud.dismiss()
      } else {
        self.presentErrorAlert(title: "Cannot get orders", with: data)
      }
    }
  }

  private func fetchFavoriteBooks() {
    hud.show(in: view)
    NetworkManagement.getAllFavorBooks { code, data in
      if code == ResponseCode.ok.rawValue {
        let books = Book.parseData(json: data)
        self.favoriteBooks = books
        self.tableView.reloadData()
        self.hud.dismiss()
      } else {
        self.presentErrorAlert(title: "Cannot get favorite books", with: data)
        return
      }
    }
  }

  private func fetchUserInfo() {
    hud.show(in: view)
    NetworkManagement.getInformationOfUser { code, data in
      if code == ResponseCode.ok.rawValue {
        self.user = User.parseData(json: data["user"])
        self.hud.dismiss()
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

// MARK: UINavigationControllerDelegate, UIImagePickerControllerDelegate

extension ProfileTableViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {

  // MARK: Internal

  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true)
  }

  func imagePickerController(
    _ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
  ) {
    if let image = info[.originalImage] as? UIImage {
      selectedImage = image
      hud.show(in: view)
      NetworkManagement.uploadProfileImage(image: image) { imageResCode, imageResData in
        if imageResCode == ResponseCode.ok.rawValue {
          let thumbnails = self.putUserImageUrl(json: imageResData)
          let imageUrl = thumbnails[0]
          NetworkManagement.putProfileImageUrl(imageUrl) { code, data in
            if code == ResponseCode.ok.rawValue {
              self.hud.textLabel.text = "Success upload profile image"
              self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
              self.hud.show(in: self.view)
              self.hud.dismiss(afterDelay: 1.0)
              self.fetchUserInfo()
            } else {
              self.presentErrorAlert(with: data)
            }
          }
        } else {
          self.presentErrorAlert(with: imageResData)
        }
      }
    }
    dismiss(animated: true)
  }

  // MARK: Private

  private func putUserImageUrl(json: JSON) -> [String] {
    var strings = [String]()
    if let arr = json["thumbnails"].array {
      arr.forEach { item in
        strings.append(item.string ?? "")
      }
    }
    return strings
  }
}

//
//  MyFavoriteController.swift
//  bsuser
//
//  Created by Khoa Le on 16/12/2020.
//

import JGProgressHUD
import UIKit

final class MyFavoriteController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  // MARK: Internal

  @IBOutlet weak var tableView: UITableView!
  var books = [Book]()
  let hud = JGProgressHUD(style: .dark)

  override func viewDidLoad() {
    super.viewDidLoad()

    title = "My favorite"
    tableView.dataSource = self
    tableView.delegate = self
    tableView.backgroundColor = Styles.Colors.background.color
    tableView.separatorStyle = .none

    navigationItem.leftBarButtonItem = UIBarButtonItem(
      image: UIImage(named: "back"),
      style: .plain,
      target: self,
      action: #selector(didTappedBackButton)
    )
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: animated)
    fetchFavoriteBooks()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
    books.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: "FavoriteCell",
      for: indexPath
    ) as? FavoriteCell else { return UITableViewCell() }
    cell.selectionStyle = .none
    cell.book = books[indexPath.row]
    return cell
  }

  func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
    135 + 16 + 16
  }

  func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
    let bookDetailController = BookDetailController()
    bookDetailController.modalPresentationStyle = .fullScreen
    bookDetailController.book = books[indexPath.row]
    let navVC = UINavigationController(rootViewController: bookDetailController)
    navVC.modalPresentationStyle = .fullScreen
    present(navVC, animated: true)
  }

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
    books.count > 0 ? 0 : 400
  }

  // MARK: Private

  private func fetchFavoriteBooks() {
    hud.show(in: view)
    NetworkManagement.getAllFavorBooks { code, data in
      if code == ResponseCode.ok.rawValue {
        let books = Book.parseData(json: data)
        self.books = books
        self.tableView.reloadData()
        self.hud.dismiss()
      } else {
        self.presentErrorAlert(title: "Cannot get favorite books", with: data)
        return
      }
    }
  }

  @objc
  private func didTappedBackButton() {
    navigationController?.popViewController(animated: true)
  }

  @objc
  private func didTappedContinueShopping() {
    tabBarController?.selectedIndex = 0
  }
}

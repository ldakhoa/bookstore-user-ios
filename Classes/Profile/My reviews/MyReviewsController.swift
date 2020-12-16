//
//  MyReviewsController.swift
//  bsuser
//
//  Created by Khoa Le on 16/12/2020.
//

import JGProgressHUD
import UIKit

// MARK: - MyReviewsController

final class MyReviewsController: UIViewController {

  // MARK: Internal

  @IBOutlet weak var tableView: UITableView!
  var reviews = [Review]()
  let hud = JGProgressHUD(style: .dark)

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.dataSource = self
    tableView.delegate = self

    title = "My reviews"

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
    fetchAllReviews()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  // MARK: Private

  @objc
  private func didTappedBackButton() {
    navigationController?.popViewController(animated: true)
  }
  private func fetchAllReviews() {
    hud.show(in: view)
    NetworkManagement.getAllReviews { code, data in
      if code == ResponseCode.ok.rawValue {
        self.reviews = Review.parseListOfReview(data)
        self.tableView.reloadData()
        self.hud.dismiss()
      } else {
        self.presentErrorAlert(title: "Cannot get reviews", with: data)
        self.hud.dismiss()
      }
    }
  }

}

// MARK: UITableViewDataSource

extension MyReviewsController: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    reviews.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyReviewCell", for: indexPath) as? MyReviewCell else { return UITableViewCell() }
    cell.selectionStyle = .none
    cell.review = reviews[indexPath.row]
    return cell
  }
}

// MARK: UITableViewDelegate

extension MyReviewsController: UITableViewDelegate {

  // MARK: Internal

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    UITableView.automaticDimension
  }

  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    300
  }

  func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
    let bookDetailController = BookDetailController()
    bookDetailController.modalPresentationStyle = .fullScreen
    hud.show(in: view)
    NetworkManagement.getBookBy(id: reviews[indexPath.row].bookId ?? "") { code, data in
      if code == ResponseCode.ok.rawValue {
        let book = Book.parseItem(item: data["book"])
        bookDetailController.book = book
        self.tableView.reloadData()
        self.hud.dismiss()
        let navVC = UINavigationController(rootViewController: bookDetailController)
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true)
      } else {
        self.presentErrorAlert(title: "Cannot get book", with: data)
        self.hud.dismiss()
      }
    }
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UIView()

    let imageView = UIImageView(image: UIImage(named: "cart_placeholder"))
    imageView.contentMode = .scaleAspectFill

    let label = UILabel(
      text: "You have no books in your order cart to review",
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
    reviews.count > 0 ? 0 : 400
  }

  // MARK: Private

  @objc
  private func didTappedContinueShopping() {
    tabBarController?.selectedIndex = 0
  }
}

//
//  BookDetailController.swift
//  bsuser
//
//  Created by Khoa Le on 22/10/2020.
//

import AudioToolbox
import JGProgressHUD
import UIKit

// MARK: - BookDetailController

final class BookDetailController: UIViewController {

  // MARK: Internal

  var book: Book?
  var recommendBooks = [Book]()
  var recommendBookFromBookId = [Book]()
  var reviews = [Review]()

  let hud = JGProgressHUD(style: .dark)
  let cellsID: [String] = [
    "BookDetailMainCell",
    "BookDetailDescriptionCell",
    "BookDetailRecommendationCell",
    "BookDetailReviewCell",
  ]
  let topContainerView = BookDetailTopContainerView()
  let bottomContainerView = BookDetailBottomContainerView()

  var contentOffsetYAfter: CGFloat = 0

  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(
      UINib(nibName: cellsID[0], bundle: nil),
      forCellReuseIdentifier: cellsID[0]
    )
    tableView.register(
      UINib(nibName: cellsID[1], bundle: nil),
      forCellReuseIdentifier: cellsID[1]
    )
    tableView.register(BookDetailRecommendationCell.self, forCellReuseIdentifier: cellsID[2])
    tableView.register(BookDetailRecommendationCell.self, forCellReuseIdentifier: "cellID")
    tableView.register(BookDetailReviewCell.self, forCellReuseIdentifier: cellsID[3])
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    return tableView
  }()

  var popRecognizer: InteractivePopRecognizer?

  var cartInfo: CartInfo?

  override func viewDidLoad() {
    super.viewDidLoad()

    setupLayout()

    topContainerView.favoriteView.addGestureRecognizer(UITapGestureRecognizer(
      target: self,
      action: #selector(didTappedFavoriteView)
    ))

    topContainerView.favoriteSelectedView.addGestureRecognizer(UITapGestureRecognizer(
      target: self,
      action: #selector(didTappedFavoriteView)
    ))

    topContainerView.dismissView.addGestureRecognizer(UITapGestureRecognizer(
      target: self,
      action: #selector(didTappedDismissImageView)
    ))
    topContainerView.dismissView.isUserInteractionEnabled = true
    topContainerView.cartView.addGestureRecognizer(UITapGestureRecognizer(
      target: self,
      action: #selector(didTappedCartButton)
    ))

    bottomContainerView.buyNowButton.addTarget(
      self,
      action: #selector(didTappedAddToCartButton),
      for: .touchUpInside
    )

    isEnabledShadowForTopView(opacity: 0.25)

    setInteractiveRecognizer()
    fetchCart()
    fetchRecommendBooks()
    fetchRecommendBooksWithBookId()
    fetchReviews()
    fetchBook()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    navigationController?.setNavigationBarHidden(true, animated: animated)

    fetchBook()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    tableView.reloadData()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setNavigationBarHidden(false, animated: animated)
  }

  // MARK: Private

  private func fetchBook() {
    hud.show(in: view)
    NetworkManagement.getBookBy(id: book?.id ?? "") { code, data in
      if code == ResponseCode.ok.rawValue {
        let book = Book.parseItem(item: data["book"])
        self.book = book
        self.topContainerView.favoriteView.isHidden = book.isFavor ? true : false
        self.topContainerView.favoriteSelectedView.isHidden = book.isFavor ? false : true
        self.tableView.reloadData()
        self.hud.dismiss()
      } else {
        self.presentErrorAlert(title: "Cannot get book", with: data)
        self.hud.dismiss()
      }
    }
  }

  private func fetchReviews() {
    hud.show(in: view)
    NetworkManagement.getReviewByBook(id: book?.id ?? "") { code, data in
      if code == ResponseCode.ok.rawValue {
        self.reviews = Review.parseListOfReview(data)
        self.tableView.reloadData()
        self.hud.dismiss()
      } else {
        self.presentErrorAlert(with: data)
      }
    }
  }

  private func fetchCart() {
    hud.show(in: view)
    NetworkManagement.getCartInfoByUser { code, data in
      if code == ResponseCode.ok.rawValue {
        self.cartInfo = CartInfo.parseData(json: data)
        self.topContainerView.itemCountLabel.isHidden = self.cartInfo?.booksQuantity ?? 0 > 0 ? false : true
        self.topContainerView.itemCountLabel.text = "\(self.cartInfo?.booksQuantity ?? 0)"
        self.topContainerView.itemCountLabel.setNeedsLayout()
        self.topContainerView.itemCountLabel.layoutIfNeeded()

        if let referenceForTabBarController = self.presentingViewController as? MainTabBarController,
           let tabItems = referenceForTabBarController.tabBar.items
        {
          let tabItem = tabItems[2]
          if self.cartInfo?.booksQuantity ?? 0 <= 0 {
            tabItem.badgeValue = nil
          } else {
            tabItem.badgeValue = "\(self.cartInfo?.booksQuantity ?? 0)"
            referenceForTabBarController.repositionBadge()
          }
        }

        self.hud.dismiss()
      } else {
        self.presentErrorAlert(with: data)
      }
    }
  }

  private func fetchRecommendBooks() {
    hud.show(in: view)
    NetworkManagement.getRecommendBooks { code, data in
      if code == ResponseCode.ok.rawValue {
        self.recommendBooks = Book.parseRecommendBooksData(json: data)
        self.tableView.reloadData()
        self.hud.dismiss()
      } else {
        self.presentErrorAlert(with: data)
      }
    }
  }

  private func fetchRecommendBooksWithBookId() {
    hud.show(in: view)
    NetworkManagement.getRecommendFromBook(id: book?.id ?? "") { code, data in
      if code == ResponseCode.ok.rawValue {
        self.recommendBookFromBookId = Book.parseRecommendBooksByBookIdData(json: data)
        self.tableView.reloadData()
        self.hud.dismiss()
      } else {
        self.presentErrorAlert(with: data)
      }
    }
  }

  private func setupLayout() {
    view.backgroundColor = UIColor.white

    view.addSubview(bottomContainerView)
    view.addSubview(tableView)
    view.addSubview(topContainerView)

    bottomContainerView.anchor(
      top: nil,
      leading: view.leadingAnchor,
      bottom: view.bottomAnchor,
      trailing: view.trailingAnchor,
      padding: .init(top: 0, left: 0, bottom: 20, right: 0),
      size: .init(width: 0, height: 90)
    )

    topContainerView.anchor(
      top: view.safeAreaLayoutGuide.topAnchor,
      leading: view.leadingAnchor,
      bottom: nil,
      trailing: view.trailingAnchor,
      size: .init(width: 0, height: Styles.Sizes.heightTopView)
    )

    tableView.anchor(
      top: view.safeAreaLayoutGuide.topAnchor,
      leading: view.leadingAnchor,
      bottom: bottomContainerView.topAnchor,
      trailing: view.trailingAnchor
    )
  }

  private func setInteractiveRecognizer() {
    guard let controller = navigationController else { return }
    popRecognizer = InteractivePopRecognizer(controller: controller)
    controller.interactivePopGestureRecognizer?.delegate = popRecognizer
  }

  @objc
  private func didTappedFavoriteView() {
    if book?.isFavor ?? false == true {
      NetworkManagement.deleteFavorBookWithBookId(book?.id ?? "") { code, data in
        if code == ResponseCode.ok.rawValue {
          self.topContainerView.favoriteSelectedView.isHidden = true
          self.topContainerView.favoriteView.isHidden = false
          self.topContainerView.favoriteView.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
          self.hud.show(in: self.view)
          self.hud.dismiss(afterDelay: 1.0)
          UIView.animate(withDuration: 0.5) {
            self.topContainerView.favoriteView.transform = .identity
          }
        } else {
          self.presentErrorAlert(title: "Cannot add to favorite", with: data)
          return
        }
      }
    } else {
      NetworkManagement.postFavorBookWithBookId(book?.id ?? "") { code, data in
        if code == ResponseCode.ok.rawValue {
          self.hud.textLabel.text = "Added to favorite"
          self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
          self.topContainerView.favoriteSelectedView.isHidden = false
          self.topContainerView.favoriteView.isHidden = true
          self.topContainerView.favoriteSelectedView.transform = CGAffineTransform(
            scaleX: 2.5,
            y: 2.5
          )
          self.hud.show(in: self.view)
          self.hud.dismiss(afterDelay: 1.0)
          UIView.animate(withDuration: 0.5) {
            self.topContainerView.favoriteSelectedView.transform = .identity
          }
        } else {
          self.presentErrorAlert(title: "Cannot add to favorite", with: data)
          return
        }
      }
    }
  }

  @objc
  private func didTappedDismissImageView() {
    let vc = navigationController?.viewControllers.first
    if vc == navigationController?.visibleViewController {
      dismiss(animated: true)
    } else {
      navigationController?.popViewController(animated: true)
    }
  }

  @objc
  private func didTappedCartButton() {
    guard let referenceForTabBarController = presentingViewController as? MainTabBarController else { return }
    dismiss(animated: true) {
      referenceForTabBarController.selectedIndex = 2
    }
  }

  @objc
  private func didTappedAddToCartButton() {
    if AppSecurity.shared.isAuthorized == false {
      guard let loginVC = AppSetting.Storyboards.Registration.login as? LoginViewController else { return }
      loginVC.isInBookDetail = true
      present(loginVC, animated: true)
    }

    NetworkManagement.postCartByUser(bookId: book?.id ?? "") { code, data in
      if code == ResponseCode.ok.rawValue {
        self.fetchCart()
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Added to cart"
        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 1.0)

        self.topContainerView.cartView.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
        UIView.animate(withDuration: 0.5) {
          self.topContainerView.cartView.transform = .identity
        }
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

// MARK: UITableViewDataSource

extension BookDetailController: UITableViewDataSource {
  func numberOfSections(in _: UITableView) -> Int {
    cellsID.count + 1
  }

  func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
    1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      guard let cell = tableView.dequeueReusableCell(
        withIdentifier: cellsID[0],
        for: indexPath
      ) as? BookDetailMainCell else { return UITableViewCell() }
      cell.book = book
      cell.selectionStyle = .none
      return cell
    } else if indexPath.section == 1 {
      guard let cell = tableView.dequeueReusableCell(
        withIdentifier: cellsID[1],
        for: indexPath
      ) as? BookDetailDescriptionCell else { return UITableViewCell() }
      cell.book = book
      cell.selectionStyle = .none
      return cell
    } else if indexPath.section == 2 {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: cellsID[3], for: indexPath) as? BookDetailReviewCell else { return UITableViewCell() }
      cell.selectionStyle = .none
      cell.reviewsHorizontalController.reviews = reviews
      return cell
    } else if indexPath.section == 3 {
      guard let cell = tableView.dequeueReusableCell(
        withIdentifier: cellsID[2],
        for: indexPath
      ) as? BookDetailRecommendationCell else { return UITableViewCell() }
      cell.selectionStyle = .none
      cell.bookDetailRecommendHorizontalController.recommendBooks = recommendBooks
      cell.bookDetailRecommendHorizontalController.delegate = self
      return cell
    } else if indexPath.section == 4 {
      guard let cell = tableView.dequeueReusableCell(
        withIdentifier: "cellID",
        for: indexPath
      ) as? BookDetailRecommendationCell else { return UITableViewCell() }
      cell.titleLabel.text = "Customers who bought this item also bought"
      cell.selectionStyle = .none
      cell.bookDetailRecommendHorizontalController.recommendBooks = recommendBookFromBookId
      cell.bookDetailRecommendHorizontalController.delegate = self
      return cell
    }
    return UITableViewCell()
  }
}

// MARK: UITableViewDelegate

extension BookDetailController: UITableViewDelegate {

  // MARK: Internal

  func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 2 {
      return reviews.count > 0 ? 280 : 0
    } else if indexPath.section == 3 {
      return 376
    } else if indexPath.section == 4 {
      return 396
    }
    return UITableView.automaticDimension
  }

  func tableView(_: UITableView, estimatedHeightForRowAt _: IndexPath) -> CGFloat {
    460
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y > 150 {
      let alpha = scrollView.contentOffset.y / 230
      let opacityRemainder = 0.25 - scrollView.contentOffset.y / 1000
      isEnabledShadowForTopView(opacity: Float(opacityRemainder))
      topContainerView.backgroundColor = Styles.Colors.White.normal.withAlphaComponent(alpha)
      if contentOffsetYAfter > 0, scrollView.contentOffset.y > 200 {
        topContainerView.bottomLayer.backgroundColor = Styles.Colors.separate.color.withAlphaComponent(alpha).cgColor
        contentOffsetYAfter = scrollView.contentOffset.y
      } else if scrollView.contentOffset.y - contentOffsetYAfter < 0, scrollView.contentOffset.y < 200 {
        topContainerView.bottomLayer.backgroundColor = Styles.Colors.separate.color.withAlphaComponent(0).cgColor
      }
      contentOffsetYAfter = scrollView.contentOffset.y
    } else {
      topContainerView.backgroundColor = Styles.Colors.White.normal.withAlphaComponent(0)
      topContainerView.bottomLayer.backgroundColor = Styles.Colors.separate.color.withAlphaComponent(0).cgColor
    }
  }

  // MARK: Private

  private func isEnabledShadowForTopView(opacity: Float) {
    topContainerView.dismissView.toTopViewShadow(opacity: opacity)
    topContainerView.favoriteView.toTopViewShadow(opacity: opacity)
    topContainerView.favoriteSelectedView.toTopViewShadow(opacity: opacity)
    topContainerView.cartView.toTopViewShadow(opacity: opacity)
  }
}

// MARK: BookDetailRecommendHorizontalControllerDelegate

extension BookDetailController: BookDetailRecommendHorizontalControllerDelegate {
  func didSelectedBook(_ book: Book) {
    let bookDetailController = BookDetailController()
    bookDetailController.modalPresentationStyle = .fullScreen
    bookDetailController.book = book
    navigationController?.pushViewController(bookDetailController, animated: true)
  }
}

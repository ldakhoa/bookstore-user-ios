//
//  MyOrdersController.swift
//  bsuser
//
//  Created by Khoa Le on 06/11/2020.
//

import JGProgressHUD
import UIKit

// MARK: - MyOrdersController

final class MyOrdersController: UIViewController {

  // MARK: Internal

  let cellID = "cellID"
  var orders = [Order]()
  var processingOrders = [Order]()
  var deliveredOrders = [Order]()
  var cancelledOrders = [Order]()
  let hud = JGProgressHUD(style: .dark)

  let titleLabel = UILabel(
    text: "My Orders",
    font: Styles.Text.h1.preferredFont,
    textColor: Styles.Colors.black.color,
    textAlignment: .left
  )

  let dismissButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "dismiss").withRenderingMode(.alwaysOriginal), for: .normal)
    button.addTarget(self, action: #selector(didTappedDismissButton), for: .touchUpInside)
    return button
  }()

  let colors: [UIColor] = [.systemPink, .blue, .brown]

  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 0
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = Styles.Colors.background.color
    cv.register(MyOrdersMainCell.self, forCellWithReuseIdentifier: cellID)
    cv.dataSource = self
    cv.delegate = self
    cv.isPagingEnabled = true
    cv.showsHorizontalScrollIndicator = false
    return cv
  }()

  let menuController = MenuCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = Styles.Colors.White.normal
    menuController.collectionView.selectItem(
      at: [0, 0],
      animated: true,
      scrollPosition: .centeredHorizontally
    )
    menuController.delegate = self
    navigationController?.navigationBar.prefersLargeTitles = true

    setupLayout()

    fetchOrderByStatus()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setNavigationBarHidden(false, animated: animated)
  }

  // MARK: Private

  private func fetchOrderByStatus() {
    let dispatchGroup = DispatchGroup()
    hud.show(in: view)

    dispatchGroup.enter()
    NetworkManagement.getAllOrdersByStatus(OrderStatus.processing.rawValue) { code, data in
      if code == ResponseCode.ok.rawValue {
        self.processingOrders = Order.parseAllOrders(json: data)
        dispatchGroup.leave()
      } else {
        self.presentErrorAlert(with: data)
      }
    }

    dispatchGroup.enter()
    NetworkManagement.getAllOrdersByStatus(OrderStatus.delivered.rawValue) { code, data in
      if code == ResponseCode.ok.rawValue {
        self.deliveredOrders = Order.parseAllOrders(json: data)
        dispatchGroup.leave()
      } else {
        self.presentErrorAlert(with: data)
      }
    }

    // TODO: - Rename cancel
    dispatchGroup.enter()
    NetworkManagement.getAllOrdersByStatus(OrderStatus.cancelled.rawValue) { code, data in
      if code == ResponseCode.ok.rawValue {
        self.cancelledOrders = Order.parseAllOrders(json: data)
        dispatchGroup.leave()
      } else {
        self.presentErrorAlert(with: data)
      }
    }

    dispatchGroup.notify(queue: .main) {
      self.collectionView.reloadData()
      self.hud.dismiss()
    }
  }

  private func setupLayout() {
    guard let menuView = menuController.view else { return }

    view.addSubview(dismissButton)
    view.addSubview(titleLabel)
    view.addSubview(menuView)
    view.addSubview(collectionView)

    dismissButton.anchor(
      top: view.safeAreaLayoutGuide.topAnchor,
      leading: view.leadingAnchor,
      bottom: nil,
      trailing: nil,
      padding: .init(top: 24, left: 24, bottom: 0, right: 0),
      size: .init(width: 24, height: 24)
    )
    titleLabel.anchor(
      top: dismissButton.bottomAnchor,
      leading: view.leadingAnchor,
      bottom: nil,
      trailing: view.trailingAnchor,
      padding: .init(top: 24, left: 24, bottom: 0, right: 24)
    )
    menuView.anchor(
      top: titleLabel.bottomAnchor,
      leading: view.leadingAnchor,
      bottom: nil,
      trailing: view.trailingAnchor,
      padding: .init(top: 24, left: 0, bottom: 0, right: 0),
      size: .init(width: 0, height: 60)
    )
    collectionView.anchor(
      top: menuView.bottomAnchor,
      leading: view.leadingAnchor,
      bottom: view.safeAreaLayoutGuide.bottomAnchor,
      trailing: view.trailingAnchor,
      padding: .init(top: 0, left: 0, bottom: 0, right: 0)
    )
  }

  @objc
  private func didTappedDismissButton() {
    dismiss(animated: true)
  }

}

// MARK: UICollectionViewDataSource

extension MyOrdersController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    MyOrderItems.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: cellID,
      for: indexPath
    ) as? MyOrdersMainCell else { return UICollectionViewCell() }
    cell.myOrdersItemController.delegate = self
    if indexPath.item == MyOrderItems.processing.rawValue {
      cell.myOrdersItemController.orders = processingOrders
      cell.myOrdersItemController.isSelectedInStatus = .processing
    } else if indexPath.item == MyOrderItems.delivered.rawValue {
      cell.myOrdersItemController.orders = deliveredOrders
      cell.myOrdersItemController.isSelectedInStatus = .delivered
    } else if indexPath.item == MyOrderItems.cancelled.rawValue {
      cell.myOrdersItemController.orders = cancelledOrders
      cell.myOrdersItemController.isSelectedInStatus = .cancelled
    }

    return cell
  }
}

// MARK: UICollectionViewDelegateFlowLayout

extension MyOrdersController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let spacing: CGFloat = 50 + 24 * 7 + 20
    return .init(width: view.frame.width, height: view.frame.height - spacing)
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let x = scrollView.contentOffset.x
    let offset = x / 3
    menuController.menuBarView.transform = CGAffineTransform(translationX: offset, y: 0)
  }

  func scrollViewWillEndDragging(
    _ scrollView: UIScrollView,
    withVelocity velocity: CGPoint,
    targetContentOffset: UnsafeMutablePointer<CGPoint>
  ) {
    let x = targetContentOffset.pointee.x
    let item = x / view.frame.width
    let indexPath = IndexPath(item: Int(item), section: 0)

    menuController.collectionView.selectItem(
      at: indexPath,
      animated: true,
      scrollPosition: .centeredHorizontally
    )
  }
}

// MARK: MenuCollectionViewControllerDelegate

extension MyOrdersController: MenuCollectionViewControllerDelegate {
  func didTappedMenuItem(at indexPath: IndexPath) {
    collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
  }
}

// MARK: MyOrdersItemControllerDelegate

extension MyOrdersController: MyOrdersItemControllerDelegate {
  func didTappedContinueShopping() {
    guard let referenceForTabBarController = presentingViewController as? MainTabBarController else { return }
    dismiss(animated: true) {
      referenceForTabBarController.selectedIndex = 0
    }
  }

  func didTappedBuyAgainButton(book: Book) {
    let bookDetailController = BookDetailController()
    bookDetailController.modalPresentationStyle = .fullScreen
    bookDetailController.book = book
    let navVC = UINavigationController(rootViewController: bookDetailController)
    navVC.modalPresentationStyle = .fullScreen
    present(navVC, animated: true)
  }

  func didSelectItemCellAt(_ indexPath: IndexPath, with status: OrderStatus) {
    guard let orderDetailController = AppSetting.Storyboards.Profile.orderDetailVC as? OrderDetailController else { return }
    orderDetailController.orderStatus = status
    switch status {
    case .processing:
      orderDetailController.orderID = processingOrders[indexPath.row].id
    case .delivered:
      orderDetailController.orderID = deliveredOrders[indexPath.row].id
    case .cancelled:
      orderDetailController.orderID = cancelledOrders[indexPath.row].id
    }

    navigationController?.pushViewController(orderDetailController, animated: true)
  }
}

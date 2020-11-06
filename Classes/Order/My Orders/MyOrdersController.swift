//
//  MyOrdersController.swift
//  bsuser
//
//  Created by Khoa Le on 06/11/2020.
//

import UIKit

// MARK: - MyOrdersController

final class MyOrdersController: UIViewController {

  // MARK: Internal

  let cellID = "cellID"
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
    cv.backgroundColor = .red
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

    menuController.collectionView.selectItem(
      at: [0, 0],
      animated: true,
      scrollPosition: .centeredHorizontally
    )
    menuController.delegate = self
    navigationController?.navigationBar.prefersLargeTitles = true
    guard let menuView = menuController.view else { return }

    view.backgroundColor = Styles.Colors.background.color
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
      bottom: view.bottomAnchor,
      trailing: view.trailingAnchor,
      padding: .init(top: 0, left: 0, bottom: 0, right: 0)
    )

  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: animated)
  }

  // MARK: Private

  @objc
  private func didTappedDismissButton() {
    dismiss(animated: true)
  }

}

// MARK: UICollectionViewDataSource

extension MyOrdersController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    3
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
    cell.backgroundColor = colors[indexPath.item]
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
    let spacing: CGFloat = 50 + 24 * 7 + 60
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

    menuController.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
  }
}

// MARK: MenuCollectionViewControllerDelegate

extension MyOrdersController: MenuCollectionViewControllerDelegate {
  func didTappedMenuItem(indexPath: IndexPath) {
    collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
  }
}

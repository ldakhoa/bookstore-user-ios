//
//  MenuCollectionViewController.swift
//  bsuser
//
//  Created by Khoa Le on 06/11/2020.
//

import UIKit

// MARK: - MenuCollectionViewControllerDelegate

protocol MenuCollectionViewControllerDelegate: AnyObject {
  func didTappedMenuItem(indexPath: IndexPath)
}

// MARK: - MenuCollectionViewController

final class MenuCollectionViewController: UICollectionViewController {

  // MARK: Internal

  let menuBarView: UIView = {
    let v = UIView()
    v.backgroundColor = Styles.Colors.primary.color
    return v
  }()

  var delegate: MenuCollectionViewControllerDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellID)
    collectionView.backgroundColor = .white
    collectionView.showsHorizontalScrollIndicator = false

    if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
      layout.scrollDirection = .horizontal
      layout.minimumLineSpacing = 0
      layout.minimumInteritemSpacing = 0
    }

    view.addSubview(menuBarView)
    menuBarView.anchor(
      top: nil,
      leading: view.leadingAnchor,
      bottom: view.bottomAnchor,
      trailing: nil,
      size: .init(width: 0, height: 5)
    )
    menuBarView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1 / 3).isActive = true
  }

  override func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    Items.count
  }

  override func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? MenuCell else { return UICollectionViewCell() }
    switch indexPath.item {
    case Items.processing.rawValue:
      cell.titleLabel.text = Items.processing.getTitleString()
    case Items.delivered.rawValue:
      cell.titleLabel.text = Items.delivered.getTitleString()
    case Items.cancelled.rawValue:
      cell.titleLabel.text = Items.cancelled.getTitleString()
    default:
      Void()
    }
    return cell
  }

  override func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    let x = view.frame.width / 3 * CGFloat(indexPath.item)
    UIView.animate(
      withDuration: 0.5,
      delay: 0,
      usingSpringWithDamping: 1,
      initialSpringVelocity: 1,
      options: .curveEaseOut
    ) {
      self.menuBarView.transform = CGAffineTransform(translationX: x, y: 0)
    }
    delegate?.didTappedMenuItem(indexPath: indexPath)
  }

  // MARK: Private

  private enum Items: Int, CaseIterable {
    case processing = 0
    case delivered = 1
    case cancelled = 2

    static let count = Items.allCases.count

    func getTitleString() -> String {
      switch self {
      case .processing:
        return "Processing"
      case .delivered:
        return "Delivered"
      case .cancelled:
        return "Cancelled"
      }
    }
  }

  private let cellID = "cellID"
}

// MARK: UICollectionViewDelegateFlowLayout

extension MenuCollectionViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let width = view.frame.width
    return .init(width: width / 3, height: view.frame.height)
  }
}

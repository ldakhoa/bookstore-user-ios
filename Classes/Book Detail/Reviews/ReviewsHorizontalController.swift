//
//  ReviewsHorizontalController.swift
//  bsuser
//
//  Created by Khoa Le on 13/12/2020.
//

import UIKit

// MARK: - ReviewsHorizontalController

final class ReviewsHorizontalController: HorizontalSnappingController {

  var reviews = [Review]() {
    didSet {
      collectionView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.register(
      UINib(nibName: "ReviewCell", bundle: nil),
      forCellWithReuseIdentifier: "ReviewCell"
    )

  }

  override func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
    reviews.count
  }

  override func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: "ReviewCell",
      for: indexPath
    ) as? ReviewCell else { return UICollectionViewCell() }
    cell.review = reviews[indexPath.item]
    return cell
  }

  //	func collectionView(
  //		_: UICollectionView,
  //		layout _: UICollectionViewLayout,
  //		minimumLineSpacingForSectionAt _: Int
  //	) -> CGFloat {
  //		return 16
  //	}
}

// MARK: UICollectionViewDelegateFlowLayout

extension ReviewsHorizontalController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _: UICollectionView,
    layout _: UICollectionViewLayout,
    sizeForItemAt _: IndexPath
  ) -> CGSize {
    .init(width: view.frame.width - 48, height: view.frame.height)
  }
}

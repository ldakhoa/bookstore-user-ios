//
//  BookDetailRecommendationHorizontalController.swift
//  bsuser
//
//  Created by Khoa Le on 23/10/2020.
//

import UIKit

// MARK: - BookDetailRecommendHorizontalControllerDelegate

protocol BookDetailRecommendHorizontalControllerDelegate: AnyObject {
  func didSelectedBook(_ book: Book)
}

// MARK: - BookDetailRecommendHorizontalControllerHomeDelegate

protocol BookDetailRecommendHorizontalControllerHomeDelegate: AnyObject {
  func didSelectedBook(_ book: Book)
}

// MARK: - BookDetailRecommendHorizontalController

final class BookDetailRecommendHorizontalController: HorizontalSnappingController {

  weak var delegate: BookDetailRecommendHorizontalControllerDelegate?
  weak var homeDelegate: BookDetailRecommendHorizontalControllerHomeDelegate?

  var recommendBooks = [Book]() {
    didSet {
      collectionView.reloadData()
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.register(
      UINib(nibName: "BookDetailRecommendCollectionCell", bundle: nil),
      forCellWithReuseIdentifier: "BookDetailRecommendCollectionCell"
    )
  }

  override func collectionView(
    _: UICollectionView,
    numberOfItemsInSection _: Int
  ) -> Int {
    recommendBooks.count
  }

  override func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: "BookDetailRecommendCollectionCell",
      for: indexPath
    ) as? BookDetailRecommendCollectionCell else { return UICollectionViewCell() }
    cell.book = recommendBooks[indexPath.item]
    return cell
  }

  override func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    let book = recommendBooks[indexPath.row]
    delegate?.didSelectedBook(book)
    homeDelegate?.didSelectedBook(book)
  }
}

// MARK: UICollectionViewDelegateFlowLayout

extension BookDetailRecommendHorizontalController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _: UICollectionView,
    layout _: UICollectionViewLayout,
    sizeForItemAt _: IndexPath
  ) -> CGSize {
    .init(width: 170, height: view.frame.height)
  }
}

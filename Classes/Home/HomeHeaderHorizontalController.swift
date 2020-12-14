//
//  ReviewHeaderHorizontalController.swift
//  bsuser
//
//  Created by Khoa Le on 14/12/2020.
//

import UIKit

// MARK: - HomeHeaderBook

struct HomeHeaderBook {
  let image: UIImage
  let title: String

}

// MARK: - HomeHeaderHorizontalController

final class HomeHeaderHorizontalController: HorizontalSnappingController {

  // MARK: Internal

  var headerBooks = [
    HomeHeaderBook(
      image: UIImage(named: "home_header1")!,
      title: "She read books as one would breathe air, to fill up and live."
    ),
    HomeHeaderBook(
      image: UIImage(named: "home_header2")!,
      title: "The world was hers for the reading."
    ),
    HomeHeaderBook(
      image: UIImage(named: "home_header3")!,
      title: "That's the thing about books. They let you travel without moving your feet."
    ),
    HomeHeaderBook(
      image: UIImage(named: "home_header4")!,
      title: "Let us remember: One book, one pen, one child, and one teacher can change the world."
    ),
    HomeHeaderBook(
      image: UIImage(named: "home_header5")!,
      title: "Reading is a conversation. All books talk. But a good book listens as well."
    ),
  ]

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.register(HomeHeaderCell.self, forCellWithReuseIdentifier: cellID)
    collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
  }

  // MARK: Private

  private let cellID = "cellID"

}

extension HomeHeaderHorizontalController {
  override func collectionView(
    _: UICollectionView,
    numberOfItemsInSection _: Int
  ) -> Int {
    headerBooks.count
  }

  override func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: cellID,
      for: indexPath
    ) as? HomeHeaderCell else { return UICollectionViewCell() }
    cell.book = headerBooks[indexPath.item]
    //		let socialApp = socialApps[indexPath.item]
    //		cell.socialApp = socialApp
    return cell
  }
}

// MARK: UICollectionViewDelegateFlowLayout

extension HomeHeaderHorizontalController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _: UICollectionView,
    layout _: UICollectionViewLayout,
    sizeForItemAt _: IndexPath
  ) -> CGSize {
    .init(width: view.frame.width - 48, height: view.frame.height)
  }
}

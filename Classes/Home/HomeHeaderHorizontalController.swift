//
//  ReviewHeaderHorizontalController.swift
//  bsuser
//
//  Created by Khoa Le on 14/12/2020.
//

import UIKit

// MARK: - Banner

struct Banner {
  let image: UIImage
  let title: String

}

// MARK: - HomeHeaderHorizontalController

final class HomeHeaderHorizontalController: HorizontalSnappingController {

  // MARK: Internal

  var banners = [
    Banner(
      image: UIImage(named: "home_header1")!,
      title: "She read books as one would breathe air, to fill up and live."
    ),
    Banner(
      image: UIImage(named: "home_header2")!,
      title: "The world was hers for the reading."
    ),
    Banner(
      image: UIImage(named: "home_header3")!,
      title: "That's the thing about books. They let you travel without moving your feet."
    ),
    Banner(
      image: UIImage(named: "home_header4")!,
      title: "Let us remember: One book, one pen, one child, and one teacher can change the world."
    ),
    Banner(
      image: UIImage(named: "home_header5")!,
      title: "Reading is a conversation. All books talk. But a good book listens as well."
    ),
  ]

  var bannerItem = 1

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.register(HomeHeaderCell.self, forCellWithReuseIdentifier: cellID)
    collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)

    setTimerAutoScroll()
  }

  func setTimerAutoScroll() {
    let _ = Timer.scheduledTimer(
      timeInterval: 3.0,
      target: self,
      selector: #selector(autoScroll),
      userInfo: nil,
      repeats: true
    )
  }

  // MARK: Private

  private let cellID = "cellID"

  @objc
  private func autoScroll() {
    if bannerItem < banners.count {
      let indexPath = IndexPath(item: bannerItem, section: 0)
      collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
      bannerItem += 1
    } else {
      bannerItem = 0
      collectionView.scrollToItem(
        at: IndexPath(item: 0, section: 0),
        at: .centeredHorizontally,
        animated: true
      )
    }
  }

}

extension HomeHeaderHorizontalController {
  override func collectionView(
    _: UICollectionView,
    numberOfItemsInSection _: Int
  ) -> Int {
    banners.count
  }

  override func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: cellID,
      for: indexPath
    ) as? HomeHeaderCell else { return UICollectionViewCell() }
    cell.banner = banners[indexPath.item]
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

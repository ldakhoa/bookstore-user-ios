//
//  HorizontalSnappingController.swift
//  bsuser
//
//  Created by Khoa Le on 23/10/2020.
//

import UIKit

// MARK: - HorizontalSnappingController

class HorizontalSnappingController: UICollectionViewController {
  init() {
    let layout = SnappingCollectionViewLayout()
    layout.scrollDirection = .horizontal
    super.init(collectionViewLayout: layout)
    collectionView.backgroundColor = .white
    collectionView.decelerationRate = .fast
    collectionView.showsHorizontalScrollIndicator = false
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - SnappingCollectionViewLayout

class SnappingCollectionViewLayout: UICollectionViewFlowLayout {
  override func targetContentOffset(
    forProposedContentOffset proposedContentOffset: CGPoint,
    withScrollingVelocity velocity: CGPoint
  ) -> CGPoint {
    guard let collectionView = collectionView else {
      return super.targetContentOffset(
        forProposedContentOffset: proposedContentOffset,
        withScrollingVelocity: velocity
      )
    }

    var offsetAdjustment = CGFloat.greatestFiniteMagnitude
    let horizontalOffset = proposedContentOffset.x + collectionView.contentInset.left

    let targetRect = CGRect(
      x: proposedContentOffset.x,
      y: 0,
      width: collectionView.bounds.size.width,
      height: collectionView.bounds.size.height
    )

    let layoutAttributesArray = super.layoutAttributesForElements(in: targetRect)

    layoutAttributesArray?.forEach { layoutAttributes in
      let itemOffset = layoutAttributes.frame.origin.x
      if fabsf(Float(itemOffset - horizontalOffset)) < fabsf(Float(offsetAdjustment)) {
        offsetAdjustment = itemOffset - horizontalOffset
      }
    }

    return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
  }
}

//
//  MyOrdersMainCell.swift
//  bsuser
//
//  Created by Khoa Le on 06/11/2020.
//

import UIKit

final class MyOrdersMainCell: UICollectionViewCell {

  // MARK: Lifecycle

  override init(frame: CGRect) {
    super.init(frame: frame)

    guard let itemView = myOrdersItemController.view else { return }
    addSubview(itemView)
    itemView.fillSuperview()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal

  let myOrdersItemController = MyOrdersItemController()

}

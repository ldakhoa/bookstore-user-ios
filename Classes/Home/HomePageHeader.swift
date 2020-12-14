//
//  HomePageHeader.swift
//  bsuser
//
//  Created by Khoa Le on 14/12/2020.
//

import UIKit

final class HomePageHeader: UITableViewCell {

  // MARK: Lifecycle

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    contentView.addSubview(homeHeaderHorizontalController.view)
    homeHeaderHorizontalController.view.fillSuperview()
  }

  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal

  let homeHeaderHorizontalController = HomeHeaderHorizontalController()

}

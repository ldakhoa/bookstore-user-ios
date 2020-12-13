//
//  BookDetailReviewCell.swift
//  bsuser
//
//  Created by Khoa Le on 13/12/2020.
//

import UIKit

final class BookDetailReviewCell: UITableViewCell {

  // MARK: Lifecycle

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    contentView.addSubview(titleLabel)
    contentView.addSubview(reviewsHorizontalController.view)

    titleLabel.anchor(
      top: topAnchor,
      leading: leadingAnchor,
      bottom: nil,
      trailing: trailingAnchor,
      padding: .init(top: 16, left: 24, bottom: 0, right: 24)
    )
    reviewsHorizontalController.view.anchor(
      top: titleLabel.bottomAnchor,
      leading: titleLabel.leadingAnchor,
      bottom: bottomAnchor,
      trailing: trailingAnchor,
      padding: .init(top: 16, left: 0, bottom: 24, right: 0)
    )
  }

  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal

  let reviewsHorizontalController = ReviewsHorizontalController()
  let titleLabel = UILabel(
    text: "Ratings & Reviews",
    font: Styles.Text.h3.preferredFont,
    textColor: Styles.Colors.black.color
  )

}

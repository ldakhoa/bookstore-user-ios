//
//  BookDetailRecommendationCell.swift
//  bsuser
//
//  Created by Khoa Le on 23/10/2020.
//

import UIKit

final class BookDetailRecommendationCell: UITableViewCell {

  // MARK: Lifecycle

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.isUserInteractionEnabled = false
    titleLabel.text = "Books you may like"

    addSubview(titleLabel)
    addSubview(bookDetailRecommendHorizontalController.view)

    titleLabel.anchor(
      top: topAnchor,
      leading: leadingAnchor,
      bottom: nil,
      trailing: trailingAnchor,
      padding: .init(top: 16, left: 24, bottom: 0, right: 24)
    )
    bookDetailRecommendHorizontalController.view.anchor(
      top: titleLabel.bottomAnchor,
      leading: leadingAnchor,
      bottom: bottomAnchor,
      trailing: trailingAnchor,
      padding: .init(top: 12, left: 24, bottom: 12, right: 0)
    )
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal

  let bookDetailRecommendHorizontalController = BookDetailRecommendHorizontalController()

  let titleLabel = UILabel(
    text: "Customers who bought this item also bought",
    font: Styles.Text.h3.preferredFont,
    textColor: Styles.Colors.black.color,
    numberOfLines: 2
  )
}

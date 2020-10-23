//
//  BookDetailRecommendationCell.swift
//  bsuser
//
//  Created by Khoa Le on 23/10/2020.
//

import UIKit

final class BookDetailRecommendationCell: RecommendationOverallCell {

    // MARK: Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = false
        titleLabel.text = "Books you may like"

        addSubview(bookDetailRecommendHorizontalController.view)
        bookDetailRecommendHorizontalController.view.anchor(
            top: titleLabel.bottomAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: .init(top: 12, left: 16, bottom: 12, right: 0)
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    let bookDetailRecommendHorizontalController = BookDetailRecommendHorizontalController()

}

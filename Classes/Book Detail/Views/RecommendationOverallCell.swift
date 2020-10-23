//
//  RecommendationOverallCell.swift
//  bsuser
//
//  Created by Khoa Le on 23/10/2020.
//

import UIKit

public class RecommendationOverallCell: UITableViewCell {

    // MARK: Lifecycle

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(titleLabel)
        titleLabel.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16)
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    let titleLabel = UILabel(
        text: "Customers who bought this item also bought",
        font: Styles.Text.h2.preferredFont,
        textColor: Styles.Colors.black.color,
        numberOfLines: 2
    )

}

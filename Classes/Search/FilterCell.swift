//
//  FilterCell.swift
//  bsuser
//
//  Created by Khoa Le on 13/10/2020.
//

import UIKit

final class FilterCell: UICollectionViewCell {
    @IBOutlet var containerView: UIView!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        containerView.layer.cornerRadius = Styles.Sizes.cellCornerRadius
        containerView.layer.borderColor = Styles.Colors.border.color.cgColor
        containerView.layer.borderWidth = 1

        contentView.setupShadow(
            opacity: 0.1,
            radius: Styles.Sizes.cellCornerRadius,
            offset: .init(width: 0, height: 0),
            color: Styles.Colors.black.color
        )
    }
}

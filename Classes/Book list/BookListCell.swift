//
//  SearchCell.swift
//  bsuser
//
//  Created by Khoa Le on 12/10/2020.
//

import Cosmos
import UIKit

final class BookListCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var containerImageBookView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = Styles.Colors.background.color
        containerView.layer.cornerRadius = Styles.Sizes.cellCornerRadius
        containerView.setupShadow(
            opacity: 0.1,
            radius: 8,
            offset: .init(width: 0, height: 1),
            color: Styles.Colors.black.color
        )

    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: -10,
            right: 0
        ))
    }
}

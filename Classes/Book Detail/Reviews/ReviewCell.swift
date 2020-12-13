//
//  ReviewCell.swift
//  bsuser
//
//  Created by Khoa Le on 13/12/2020.
//

import Cosmos
import UIKit

final class ReviewCell: UICollectionViewCell {
	@IBOutlet weak var userImageView: UIImageView!
	@IBOutlet weak var ratingLabel: UILabel!
	@IBOutlet weak var contentLabel: UILabel!

	override func awakeFromNib() {
    super.awakeFromNib()

    layer.cornerRadius = 8
    clipsToBounds = true
    backgroundColor = Styles.Colors.White.normal
    layer.borderColor = Styles.Colors.reviewBorder.color.cgColor
    layer.borderWidth = 1

  }
}

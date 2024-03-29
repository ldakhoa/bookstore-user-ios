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
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!

  var review: Review? {
    didSet {
      nameLabel.text = review?.user?.username
      contentLabel.text = review?.content
      ratingLabel.text = "\(review?.ratings ?? -1)"
      let date = review?.updateDate?.getDate()
      timeLabel.text = date?.timeAgoDisplay()

      if let url = URL(string: review?.user?.profileImageUrl ?? "") {
        userImageView.sd_setImage(with: url)
      }

    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    layer.cornerRadius = 8
    clipsToBounds = true
    backgroundColor = Styles.Colors.White.normal
    layer.borderColor = Styles.Colors.reviewBorder.color.cgColor
    layer.borderWidth = 1
  }

}

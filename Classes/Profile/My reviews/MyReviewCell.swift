//
//  MyReviewCell.swift
//  bsuser
//
//  Created by Khoa Le on 16/12/2020.
//

import UIKit

final class MyReviewCell: UITableViewCell {
  @IBOutlet weak var userProfileImageView: UIImageView!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var ratingsLabel: UILabel!
  @IBOutlet weak var postDateLabel: UILabel!
  @IBOutlet weak var bookImageView: UIImageView!
  @IBOutlet weak var bookTitleLabel: UILabel!
  @IBOutlet weak var contentLabel: UILabel!

  var review: Review? {
    didSet {
      if let url = URL(string: review?.userImageUrl ?? "") {
        userProfileImageView.sd_setImage(with: url)
      }

      if let url = URL(string: review?.bookImageUrl ?? "") {
        bookImageView.sd_setImage(with: url)
      }

      userNameLabel.text = review?.userName
      ratingsLabel.text = "\(review?.ratings ?? 0)"
      contentLabel.text = review?.content
      bookTitleLabel.text = review?.bookTitle
      postDateLabel.text = review?.postDate.getDate()?.timeAgoDisplay()

    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }
}

//
//  BookDetailRecommendCollectionCell.swift
//  bsuser
//
//  Created by Khoa Le on 23/10/2020.
//

import UIKit

final class BookDetailRecommendCollectionCell: UICollectionViewCell {
  @IBOutlet weak var ratingsLabel: UILabel!
  @IBOutlet weak var numberOfRatingsLabel: UILabel!
  @IBOutlet weak var bookTitleLabel: UILabel!
  @IBOutlet weak var authorsLabel: UILabel!
  @IBOutlet weak var bookImageView: UIImageView!
  @IBOutlet weak var priceLabel: UILabel!

  var book: Book? {
    didSet {
      bookTitleLabel.text = book?.title

      var authorNames = [String]()
      book?.authors.forEach {
        authorNames.append($0.name)
      }
      authorsLabel.text = "by \(authorNames.joined(separator: ", "))"

      ratingsLabel.text = "\(book?.ratings ?? 1)"
      numberOfRatingsLabel.text = "(\(book?.numberOfRatings ?? 0))"

      priceLabel.text = "\(book?.price ?? 0)"

      if let url = URL(string: book?.imageUrl ?? "") {
        bookImageView.sd_setImage(with: url)
      }
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }
}

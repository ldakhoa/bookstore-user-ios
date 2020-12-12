//
//  SearchCell.swift
//  bsuser
//
//  Created by Khoa Le on 12/10/2020.
//

import Cosmos
import SDWebImage
import UIKit

final class BookListCell: UITableViewCell {
  @IBOutlet var containerView: UIView!
  @IBOutlet var bookImageView: UIImageView!
  @IBOutlet var bookTitleLabel: UILabel!
  @IBOutlet var authorLabel: UILabel!
  @IBOutlet var ratingView: CosmosView!
  @IBOutlet var priceLabel: UILabel!
  @IBOutlet var containerImageBookView: UIView!

  var book: Book? {
    didSet {
      guard let book = book,
            let bookImageUrl = URL(string: book.imageUrl)
      else {
        return
      }

      bookTitleLabel.text = book.title
      var authorNames = [String]()
      book.authors.forEach {
        authorNames.append($0.name)
      }
      authorLabel.text = "by \(authorNames.joined(separator: ", "))"
      priceLabel.text = "$\(book.price)"
      bookImageView.sd_setImage(with: bookImageUrl)
      ratingView.rating = book.ratings
      ratingView.text = "\(book.numberOfRatings)"
    }
  }

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

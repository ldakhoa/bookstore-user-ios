//
//  BookDetailMainCell.swift
//  bsuser
//
//  Created by Khoa Le on 22/10/2020.
//

import Cosmos
import UIKit

final class BookDetailMainCell: UITableViewCell {
  @IBOutlet var bookImageView: UIImageView!
  @IBOutlet var bookTitleLabel: UILabel!
  @IBOutlet var authorLabel: UILabel!
  @IBOutlet var ratingsView: CosmosView!
  @IBOutlet var priceLabel: UILabel!

  var book: Book? {
    didSet {

      if let imageUrl = URL(string: book?.imageUrl ?? "") {
        bookImageView.sd_setImage(
          with: imageUrl,
          placeholderImage: UIImage(named: "book-placeholder")
        )
      }
      bookTitleLabel.text = book?.title
      ratingsView.rating = book?.ratings ?? 0
      ratingsView.text = "\(book?.numberOfRatings ?? 0)"
      priceLabel.text = "$\(book?.price ?? 0)"

      var authorNames = [String]()
      book?.authors.forEach {
        authorNames.append($0.name)
      }
      authorLabel.text = authorNames.joined(separator: ", ")
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }
}

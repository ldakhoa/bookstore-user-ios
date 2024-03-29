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
      guard let book = book,
            let imageUrl = URL(string: book.imageUrl) else { return }
      bookTitleLabel.text = book.title
      ratingsView.rating = book.ratings
      ratingsView.text = "\(book.numberOfRatings)"
      priceLabel.text = "$\(book.price)"
      bookImageView.sd_setImage(with: imageUrl)

      var authorNames = [String]()
      book.authors.forEach {
        authorNames.append($0.name)
      }
      authorLabel.text = authorNames.joined(separator: ", ")
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }
}

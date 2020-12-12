//
//  CartCell.swift
//  bsuser
//
//  Created by Khoa Le on 26/10/2020.
//

import UIKit

final class CartCell: UITableViewCell {
  @IBOutlet var bookImageView: UIImageView!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var authorLabel: UILabel!
  @IBOutlet var priceLabel: UILabel!
  @IBOutlet var bookAmountLabel: UILabel!
  @IBOutlet var decreaseButton: UIButton!
  @IBOutlet var increaseButton: UIButton!

  var book: Book? {
    didSet {
      guard let book = book else { return }
      titleLabel.text = book.title
      priceLabel.text = "$\(book.price)"
      bookAmountLabel.text = "\(book.quantity)"

      var authorNames = [String]()
      book.authors.forEach {
        authorNames.append($0.name)
      }
      authorLabel.text = "by \(authorNames.joined(separator: ", "))"

      if let url = URL(string: book.imageUrl) {
        bookImageView.sd_setImage(with: url)
      }
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }
}

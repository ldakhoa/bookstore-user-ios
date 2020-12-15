//
//  OrderDetailBookCell.swift
//  bsuser
//
//  Created by Khoa Le on 07/11/2020.
//

import UIKit

final class OrderDetailBookCell: UITableViewCell {
  @IBOutlet weak var bookImageView: UIImageView!
  @IBOutlet weak var bookTitleLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var bookCountLabel: UILabel!

  var book: Book? {
    didSet {
      if let url = URL(string: book?.imageUrl ?? "") {
        bookImageView.sd_setImage(with: url)
      }

      bookTitleLabel.text = book?.title
      priceLabel.text = "$\(book?.price ?? 0)"
      let countText = book?.quantity ?? 0 > 1 ? "items" : "item"
      bookCountLabel.text = "\(book?.quantity ?? 0) \(countText)"
    }

  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }
}

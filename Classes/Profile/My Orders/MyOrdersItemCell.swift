//
//  MyOrdersItemCell.swift
//  bsuser
//
//  Created by Khoa Le on 07/11/2020.
//

import UIKit

final class MyOrdersItemCell: UITableViewCell {
  @IBOutlet weak var orderStatusLabel: UILabel!
  @IBOutlet weak var bookImageView: UIImageView!
  @IBOutlet weak var titleBookLabel: UILabel!
  @IBOutlet weak var quantityAndPriceLabel: UILabel!
  @IBOutlet weak var purchaseDate: UILabel!

  var order: Order? {
    didSet {
      orderStatusLabel.text = order?.status.capitalizingFirstLetter()
      titleBookLabel.text = order?.productName

      let booksCount = order?.booksQuantity ?? 1
      let booksCountText = booksCount > 1 ? "books" : "book"
      quantityAndPriceLabel.text = "\(booksCount) \(booksCountText) | $\(order?.totalPrice ?? 0)"

      let date = order?.purchaseDate.getDate()
      purchaseDate.text = "Purchased \(date?.timeAgoDisplay() ?? "")"

      if let url = URL(string: order?.books[0].imageUrl ?? "") {
        bookImageView.sd_setImage(with: url)
      }
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }

}

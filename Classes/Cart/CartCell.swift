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

  override func awakeFromNib() {
    super.awakeFromNib()
  }
}

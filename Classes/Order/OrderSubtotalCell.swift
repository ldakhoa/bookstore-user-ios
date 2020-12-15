//
//  OrderSubtotalCell.swift
//  bsuser
//
//  Created by Khoa Le on 30/10/2020.
//

import UIKit

final class OrderSubtotalCell: UITableViewCell {

  @IBOutlet weak var subtotalPriceLabel: UILabel!
  @IBOutlet weak var shippingFeeLabel: UILabel!

  var cart: Cart? {
    didSet {
      let subtotal = cart?.subtotalPrice ?? 0
      subtotalPriceLabel.text = String(format: "$%.2f", subtotal)

      shippingFeeLabel.text = "$\(cart?.shippingFee ?? 0)"
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }
}

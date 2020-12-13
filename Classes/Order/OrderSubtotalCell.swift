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
      subtotalPriceLabel.text = "$\(cart?.subtotalPrice ?? 0)"
      shippingFeeLabel.text = "$\(cart?.shippingFee ?? 0)"
    }
  }


  override func awakeFromNib() {
    super.awakeFromNib()
  }
}

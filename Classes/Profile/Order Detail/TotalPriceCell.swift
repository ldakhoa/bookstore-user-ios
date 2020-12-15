//
//  TotalPriceCell.swift
//  bsuser
//
//  Created by Khoa Le on 07/11/2020.
//

import UIKit

final class TotalPriceCell: UITableViewCell {
  @IBOutlet weak var subtotalLabel: UILabel!
  @IBOutlet weak var shippingFeeLabel: UILabel!
  @IBOutlet weak var totalLabel: UILabel!

  var order: Order? {
    didSet {
      subtotalLabel.text = "$\(order?.subtotal ?? 0)"
      shippingFeeLabel.text = "$\(order?.shippingFee ?? 0)"
      totalLabel.text = "$\(order?.totalPrice ?? 0)"
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }
}

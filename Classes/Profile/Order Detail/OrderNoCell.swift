//
//  OrderNoCell.swift
//  bsuser
//
//  Created by Khoa Le on 07/11/2020.
//

import UIKit

final class OrderNoCell: UITableViewCell {
  @IBOutlet weak var orderNoLabel: UILabel!
  @IBOutlet weak var purchaseDateLabel: UILabel!
  @IBOutlet weak var statusLabel: UILabel!

  var order: Order? {
    didSet {
      orderNoLabel.text = "Order no: #\(order?.id ?? "")"
      purchaseDateLabel.text = "Date of purchase: \(order?.purchaseDate.getDate()?.getFormattedDate() ?? "")"

      statusLabel.text = order?.status.capitalizingFirstLetter()

    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }
}

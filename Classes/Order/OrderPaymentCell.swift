//
//  OrderPaymentCell.swift
//  bsuser
//
//  Created by Khoa Le on 30/10/2020.
//

import UIKit

final class OrderPaymentCell: UITableViewCell {
  @IBOutlet var addButton: UIButton!

  override func awakeFromNib() {
    super.awakeFromNib()

    addButton.layer.borderWidth = 1
    addButton.layer.borderColor = Styles.Colors.black.color.cgColor
    addButton.layer.cornerRadius = 8
  }
}

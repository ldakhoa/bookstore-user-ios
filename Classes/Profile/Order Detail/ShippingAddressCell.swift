//
//  ShippingAddressCell.swift
//  bsuser
//
//  Created by Khoa Le on 07/11/2020.
//

import UIKit

final class ShippingAddressCell: UITableViewCell {
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var phoneLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!

  var order: Order? {
    didSet {
      usernameLabel.text = order?.userName
      phoneLabel.text = order?.contactPhoneNumber
      addressLabel.text = order?.shippingAddress
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }
}

//
//  OrderShippingAddressCell.swift
//  bsuser
//
//  Created by Khoa Le on 30/10/2020.
//

import UIKit

final class OrderShippingAddressCell: UITableViewCell {
  @IBOutlet var nameAndPhoneNumberLabel: UILabel!
  @IBOutlet var addressLabel: UILabel!
  @IBOutlet var editButton: UIButton!

  var cart: Cart? {
    didSet {
      if cart?.shippingAddress.count ?? 0 < 10 {
        addressLabel.text = "Please fill your shipping address and your phone number."
      } else {
        nameAndPhoneNumberLabel.text = "\(cart?.userName ?? "") | +\(cart?.contactPhoneNumber ?? "+84")"
        addressLabel.text = cart?.shippingAddress
      }
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }
}

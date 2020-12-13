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
      nameAndPhoneNumberLabel.text = "\(cart?.userName ?? "") - \(cart?.phone ?? 0)"
      addressLabel.text = cart?.address
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }
}

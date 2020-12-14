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

  var user: User? {
    didSet {
      addressLabel.text = "\(user?.address ?? "") Ward \(user?.ward ?? "") District \(user?.district ?? "")"
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }
}

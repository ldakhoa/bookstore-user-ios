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
      if user?.ward?.count ?? -1 < 1 && user?.district?.count ?? -1 < 1 {
        addressLabel.text = "Please fill your shipping address and your phone number."
      } else {
        addressLabel.text = "\(user?.address ?? "") Ward \(user?.ward ?? "") District \(user?.district ?? ""), \(user?.city ?? ""), \(user?.country ?? "")"
      }
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }
}

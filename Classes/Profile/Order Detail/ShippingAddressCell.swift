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
      usernameLabel.text = order?.user?.username
      phoneLabel.text = "\(order?.user?.phone ?? 0)"
      addressLabel.text = "\(order?.user?.address ?? "") Ward \(order?.user?.ward ?? "") District \(order?.user?.district ?? ""), \(order?.user?.city ?? ""), \(order?.user?.country ?? "")"
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }
}

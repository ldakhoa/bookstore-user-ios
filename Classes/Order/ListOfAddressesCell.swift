//
//  ListOfAddressesCell.swift
//  bsuser
//
//  Created by Khoa Le on 05/11/2020.
//

import UIKit

final class ListOfAddressesCell: UITableViewCell {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var specificAddressLabel: UILabel!
  @IBOutlet weak var cityAndZIPLabel: UILabel!
  @IBOutlet weak var countryLabel: UILabel!
  @IBOutlet weak var phoneNumberLabel: UILabel!

  var user: User? {
    didSet {
      nameLabel.text = user?.username
      specificAddressLabel.text = "\(user?.address ?? "") Ward \(user?.ward ?? "") District \(user?.district ?? "")"
      cityAndZIPLabel.text = "\(user?.city ?? "") \(user?.zipCode ?? 700000)"
      countryLabel.text = user?.country
      phoneNumberLabel.text = "Phone number: \(user?.phone ?? 84)"
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }
}

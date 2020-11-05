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

  override func awakeFromNib() {
    super.awakeFromNib()
  }
}

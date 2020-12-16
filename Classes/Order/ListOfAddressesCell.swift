//
//  ListOfAddressesCell.swift
//  bsuser
//
//  Created by Khoa Le on 05/11/2020.
//

import UIKit

// MARK: - ListOfAddressesCellDelegate

protocol ListOfAddressesCellDelegate: AnyObject {
  func didTappedEditButton(at addressId: String)
}

// MARK: - ListOfAddressesCell

final class ListOfAddressesCell: UITableViewCell {

  // MARK: Internal

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var specificAddressLabel: UILabel!
  @IBOutlet weak var cityAndZIPLabel: UILabel!
  @IBOutlet weak var countryLabel: UILabel!
  @IBOutlet weak var phoneNumberLabel: UILabel!
  @IBOutlet weak var editAddressButton: UIButton!

  weak var delegate: ListOfAddressesCellDelegate?

  var address: Address? {
    didSet {
      // TODO: - Implement name + phone
      phoneNumberLabel.text = "Phone number: \(address?.contactPhoneNumber ?? "84")"
      nameLabel.text = address?.userName
      specificAddressLabel.text = "\(address?.name ?? "") Ward \(address?.ward ?? "") District \(address?.district ?? "")"
      cityAndZIPLabel.text = "\(address?.city ?? "") \(address?.zipCode ?? 700000)"
      countryLabel.text = address?.country
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    editAddressButton.addTarget(self, action: #selector(didTappedEditButton), for: .touchUpInside)
  }

  // MARK: Private

  @objc
  private func didTappedEditButton() {
    delegate?.didTappedEditButton(at: address?.id ?? "")
  }
}

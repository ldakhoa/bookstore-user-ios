//
//  OrderPaymentCell.swift
//  bsuser
//
//  Created by Khoa Le on 30/10/2020.
//

import UIKit

final class OrderPaymentCell: UITableViewCell {
  @IBOutlet var addButton: UIButton!

  @IBOutlet weak var visaLabel: UILabel!
  @IBOutlet weak var stackView: UIStackView!

  var isTappedNext: Bool?

  override func awakeFromNib() {
    super.awakeFromNib()

    addButton.layer.borderWidth = 1
    addButton.layer.borderColor = Styles.Colors.black.color.cgColor
    addButton.layer.cornerRadius = 8

    if isTappedNext ?? false {
      stackView.isHidden = true
      visaLabel.isHidden = false
    } else {
      stackView.isHidden = false
      visaLabel.isHidden = true
    }
  }
}

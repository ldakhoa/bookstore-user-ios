//
//  TrackingOrderCell.swift
//  bsuser
//
//  Created by Khoa Le on 07/11/2020.
//

import UIKit

final class TrackingOrderCell: UITableViewCell {
  @IBOutlet weak var statusLabel: UILabel!
  @IBOutlet weak var updatedDateLabel: UILabel!

  var order: Order? {
    didSet {
      statusLabel.text = order?.status.capitalizingFirstLetter()
      updatedDateLabel.text = order?.updatedDate.getDate()?.getFormattedDate(format: "H:mm, EEEE dd/MM/yyyy")
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }
}

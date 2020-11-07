//
//  MyOrdersItemCell.swift
//  bsuser
//
//  Created by Khoa Le on 07/11/2020.
//

import UIKit

final class MyOrdersItemCell: UITableViewCell {
  @IBOutlet weak var orderStatusLabel: UILabel!
  @IBOutlet weak var bookImageView: UIImageView!
  @IBOutlet weak var titleBookLabel: UILabel!
  @IBOutlet weak var quantityAndPriceLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  //	override func layoutSubviews() {
  //		super.layoutSubviews()
  //		let size: CGFloat = 12
//
  //		contentView.frame = contentView.frame.inset(by: UIEdgeInsets(
  //			top: size,
  //			left: 0,
  //			bottom: 0,
  //			right: 0
  //		))
  //	}
}

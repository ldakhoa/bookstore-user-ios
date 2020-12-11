//
//  LeftAlignedIconButton.swift
//  bsuser
//
//  Created by Khoa Le on 11/12/2020.
//

import UIKit

@IBDesignable
class LeftAlignedIconButton: UIButton {
  override func awakeFromNib() {
    super.awakeFromNib()

    layer.cornerRadius = 8
    layer.borderColor = Styles.Colors.gray.color.cgColor
    layer.borderWidth = 1
  }
  override func layoutSubviews() {
    super.layoutSubviews()
    contentHorizontalAlignment = .left
    let availableSpace = bounds.inset(by: contentEdgeInsets)
    let availableWidth = availableSpace.width - imageEdgeInsets.right - (imageView?.frame.width ?? 0) - (titleLabel?.frame.width ?? 0)
    titleEdgeInsets = UIEdgeInsets(top: 0, left: availableWidth / 2, bottom: 0, right: 0)
  }
}

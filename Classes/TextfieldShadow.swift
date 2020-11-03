//
//  TextfieldShadow.swift
//  bsuser
//
//  Created by Khoa Le on 11/10/2020.
//

import UIKit

extension UIView {
  func setTextfieldStyle() {
    layer.cornerRadius = Styles.Sizes.textFieldCornerRadius
    setupShadow(
      opacity: 0.05,
      radius: 8,
      offset: .init(width: 0, height: 1),
      color: UIColor.black
    )
  }
}

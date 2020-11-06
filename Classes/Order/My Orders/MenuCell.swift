//
//  MenuCell.swift
//  bsuser
//
//  Created by Khoa Le on 06/11/2020.
//

import UIKit

final class MenuCell: UICollectionViewCell {

  // MARK: Lifecycle

  override init(frame: CGRect) {
    super.init(frame: frame)

    addSubview(titleLabel)
    titleLabel.fillSuperview()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal

  let titleLabel = UILabel(
    text: "Menu Item",
    font: Styles.Text.body.preferredFont,
    textColor: Styles.Colors.lightGray,
    textAlignment: .center,
    numberOfLines: 1
  )

  override var isSelected: Bool {
    didSet {
      titleLabel.textColor = isSelected ? Styles.Colors.primary.color : Styles.Colors.lightGray
    }
  }
}

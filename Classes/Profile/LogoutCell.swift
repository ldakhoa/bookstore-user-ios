//
//  LogoutCell.swift
//  bsuser
//
//  Created by Khoa Le on 11/10/2020.
//

import UIKit

class LogoutCell: UITableViewCell {
  override init(style: UITableViewCell.CellStyle, reuseIdentifier _: String?) {
    super.init(style: style, reuseIdentifier: nil)
    backgroundColor = Styles.Colors.background.color
    let label = UILabel(
      text: "Log out",
      font: Styles.Text.body.preferredFont,
      textColor: Styles.Colors.darkGreen.color
    )
    addSubview(label)
    label.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 0))
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

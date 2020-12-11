//
//  CustomSkyFloatingLabelTextField.swift
//  bsuser
//
//  Created by Khoa Le on 12/12/2020.
//

import SkyFloatingLabelTextField

// MARK: - CustomSkyFloatingLabelTextField

class CustomSkyFloatingLabelTextField: SkyFloatingLabelTextField {
  override var titleFormatter: (String) -> String {
    get {
      { text in
        text.capitalizingFirstLetter()
      }
    }
    set { }
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    titleFont = Styles.Text.helper.preferredFont

  }

}

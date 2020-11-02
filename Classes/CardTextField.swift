//
//  CardTextField.swift
//  bsuser
//
//  Created by Khoa Le on 30/10/2020.
//

import UIKit

class CardTextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()

        let bottomLayer = CALayer()
        bottomLayer.frame = .init(x: 0, y: 50, width: frame.width, height: 1)
        bottomLayer.backgroundColor = Styles.Colors.textFieldBottomLine.color.cgColor

        layer.addSublayer(bottomLayer)
    }
}

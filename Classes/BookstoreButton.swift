//
//  BookstoreButton.swift
//  bsuser
//
//  Created by Khoa Le on 11/10/2020.
//

import UIKit

class BookstoreButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = Styles.Colors.primary.color
        layer.cornerRadius = Styles.Sizes.buttonCornerRadius
        layer.masksToBounds = false
        setTitleColor(.white, for: .normal)
        titleLabel?.font = Styles.Text.button.preferredFont
        setupShadow(
            opacity: 0.3,
            radius: 8,
            offset: .init(width: 0, height: 1),
            color: Styles.Colors.primary.color
        )
    }

    convenience init(color: UIColor = Styles.Colors.primary.color) {
        self.init()
        backgroundColor = color
        setupShadow(
            opacity: 0.3,
            radius: 8,
            offset: .init(width: 0, height: 1),
            color: color
        )
    }
}

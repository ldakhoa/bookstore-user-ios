//
//  BookstoreButton.swift
//  bsuser
//
//  Created by Khoa Le on 11/10/2020.
//

import UIKit

class IBooksButton: UIButton {

    // MARK: Lifecycle

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

    // MARK: Public

    public func setActiveStyles() {
        isEnabled = true
        backgroundColor = Styles.Colors.primary.color
        setTitleColor(Styles.Colors.White.normal, for: .normal)
        setupShadow(
            opacity: 0.3,
            radius: 8,
            offset: .init(width: 0, height: 1),
            color: Styles.Colors.primary.color
        )
    }

    public func setInactiveStyles() {
        isEnabled = false
        backgroundColor = Styles.Colors.lightGray
        setTitleColor(Styles.Colors.White.whiter, for: .normal)
        setupShadow(
            opacity: 0,
            radius: 0,
            offset: .zero,
            color: Styles.Colors.lightGray
        )
    }

    // MARK: Internal

    override func awakeFromNib() {
        super.awakeFromNib()

        setInactiveStyles()
        layer.cornerRadius = Styles.Sizes.buttonCornerRadius
        layer.masksToBounds = false
        titleLabel?.font = Styles.Text.button.preferredFont
    }
}

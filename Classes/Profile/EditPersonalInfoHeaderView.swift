//
//  EditPersonalInfoHeaderView.swift
//  bsuser
//
//  Created by Khoa Le on 13/10/2020.
//

import UIKit

final class EditPersonalInfoHeaderView: UIView {

    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.anchor(
            top: nil,
            leading: leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 0, left: 24, bottom: 0, right: 0)
        )
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    let label = UILabel(
        text: "",
        font: Styles.Text.titleBold.preferredFont,
        textColor: Styles.Colors.darkGreen.color
    )

}

//
//  EditPersonalInfoCell.swift
//  bsuser
//
//  Created by Khoa Le on 13/10/2020.
//

import UIKit

final class EditPersonalInfoCell: UITableViewCell {
    let textField: UITextField = {
        let tf = UITextField()
        tf.font = Styles.Text.body.preferredFont
        return tf
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(textField)
        textField.fillSuperview(padding: .init(top: 0, left: 25, bottom: 0, right: 12))
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

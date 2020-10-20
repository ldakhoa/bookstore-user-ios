//
//  EditPersonalInfoCell.swift
//  bsuser
//
//  Created by Khoa Le on 13/10/2020.
//

import UIKit

final class EditPersonalInfoCell: UITableViewCell {

    // MARK: Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(textField)
        textField.fillSuperview(padding: .init(top: 0, left: 0, bottom: 0, right: 12))
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    let textField: UITextField = {
        let tf = InfoTextField()
        tf.font = Styles.Text.body.preferredFont
        tf.textColor = Styles.Colors.black.color
        return tf
    }()

}
class InfoTextField: UITextField {
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: 44)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 24, dy: 0)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 24, dy: 0)
    }
}

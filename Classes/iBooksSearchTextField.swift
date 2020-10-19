//
//  iBooksSearchTextField.swift
//  bsuser
//
//  Created by Khoa Le on 11/10/2020.
//

import UIKit

class iBooksSearchTextField: UITextField {

    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.cornerRadius = Styles.Sizes.searchCornerRadius

        backgroundColor = .white
        placeholder = "Search iBooks"
        setupShadow(opacity: 0.25, radius: 8, offset: .init(width: 0, height: 1), color: .black)
        font = Styles.Text.body.preferredFont

        attributedPlaceholder = NSAttributedString(string: "Search iBooks", attributes: [
            NSAttributedString.Key.foregroundColor: Styles.Colors.gray.color,
            NSAttributedString.Key.font: Styles.Text.body.preferredFont,
        ])

        let leftImageView = UIImageView(image: #imageLiteral(resourceName: "Search"))
        leftView = leftImageView
        leftViewMode = .always

        let rightImageView = UIImageView(image: #imageLiteral(resourceName: "cancel-edit"))
        rightView = rightImageView
        rightViewMode = .whileEditing
        rightImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedRightImageView)))
        rightImageView.isUserInteractionEnabled = true
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: 40)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 40, dy: 0)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 40, dy: 0)
    }

    override func leftViewRect(forBounds _: CGRect) -> CGRect {
        return .init(x: 8, y: 8, width: 24, height: 24)
    }

    override func rightViewRect(forBounds _: CGRect) -> CGRect {
        return .init(x: self.frame.width - 24, y: 12, width: 16, height: 16)
    }

    @objc private func didTappedRightImageView() {
        self.text = ""
    }

}

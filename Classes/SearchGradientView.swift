//
//  SearchGradientView.swift
//  bsuser
//
//  Created by Khoa Le on 11/10/2020.
//

import UIKit

class SearchGradientView: UIView, UITextFieldDelegate {
    let searchTextField = iBooksSearchTextField()
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        button.constrainHeight(24)
        button.constrainWidth(24)
        button.isHidden = true
        return button
    }()

    var anchorConstraint: AnchoredConstraints!

    override func awakeFromNib() {
        super.awakeFromNib()

        searchTextField.delegate = self
        insertGradientBackground()

        addSubview(searchTextField)
        addSubview(backButton)

        anchorConstraint = searchTextField.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 54, left: 15, bottom: 0, right: 15),
            size: .init(width: 0, height: 40)
        )

        backButton.anchor(
            top: nil,
            leading: leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 0, left: 12, bottom: 0, right: 0),
            size: .init(width: 24, height: 24)
        )
        backButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor).isActive = true

        searchTextField.addTarget(self, action: #selector(handleTest), for: .editingChanged)
    }

    @objc func handleTest(textField: UITextField) {
        if textField.text?.count == 0 {
            setTextFieldWithoutBack()
        } else {
            setTextFieldWithBack()
        }
    }

    func insertGradientBackground() {
        let layer = CAGradientLayer()
        layer.colors = [
            Styles.Colors.Gradient.color1,
            Styles.Colors.Gradient.color2,
            Styles.Colors.Gradient.color3,
            Styles.Colors.Gradient.color4,
            Styles.Colors.Gradient.color5,
            Styles.Colors.Gradient.color6,
        ]
        layer.locations = [0, 0.21, 0.43, 0.61, 0.81, 1]
        layer.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer.transform = CATransform3DMakeAffineTransform(
            CGAffineTransform(
                a: 1, b: 0, c: 0, d: 3.66, tx: 0, ty: -1.83
            )
        )
        layer.frame = .init(x: 0, y: 0, width: frame.width, height: frame.height)
        layer.position = center
        self.layer.insertSublayer(layer, at: 0)
    }

    func setTextFieldWithoutBack() {
        backButton.isHidden = true
        anchorConstraint.leading?.constant = 15
    }

    func setTextFieldWithBack() {
        backButton.isHidden = false
        anchorConstraint.leading?.constant = 12 + 12 + 24
    }
}

//
//  SearchGradientView.swift
//  bsuser
//
//  Created by Khoa Le on 11/10/2020.
//

import UIKit

class SearchGradientView: UIView, UITextFieldDelegate {

  // MARK: Internal

  let searchTextField = IBooksSearchTextField()
  let cancelButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Cancel", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.titleLabel?.font = Styles.Text.title.preferredFont
    return button
  }()

  let backButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(#imageLiteral(resourceName: "back"), for: .normal)
    return button
  }()

//    var anchorConstraint: AnchoredConstraints!

  override func awakeFromNib() {
    super.awakeFromNib()

    searchTextField.delegate = self
    insertGradientBackground()

//        addSubview(searchTextField)
//        addSubview(cancelButton)

//        anchorConstraint =
//        searchTextField.anchor(
//            top: topAnchor,
//            leading: leadingAnchor,
//            bottom: nil,
//            trailing: cancelButton.leadingAnchor,
//            padding: .init(top: 54, left: 15, bottom: 0, right: 15),
//            size: .init(width: 0, height: 40)
//        )
//
//        cancelButton.anchor(
//            top: nil,
//            leading: nil,
//            bottom: nil,
//            trailing: trailingAnchor,
//            padding: .init(top: 0, left: 0, bottom: 0, right: 12)
//        )
//        cancelButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor).isActive = true
  }

  func layoutForOtherViewController() {
    addSubview(searchTextField)
    searchTextField.anchor(
      top: topAnchor,
      leading: leadingAnchor,
      bottom: nil,
      trailing: trailingAnchor,
      padding: .init(top: 54, left: 15, bottom: 0, right: 15),
      size: .init(width: 0, height: 40)
    )
  }

  func layoutForBookListController() {
    addSubview(searchTextField)
    addSubview(backButton)

    searchTextField.anchor(
      top: topAnchor,
      leading: backButton.trailingAnchor,
      bottom: nil,
      trailing: trailingAnchor,
      padding: .init(top: 54, left: 15, bottom: 0, right: 8),
      size: .init(width: 0, height: 40)
    )

    backButton.anchor(
      top: nil,
      leading: leadingAnchor,
      bottom: nil,
      trailing: nil,
      padding: .init(top: 0, left: 15, bottom: 0, right: 0),
      size: .init(width: 24, height: 24)
    )
    backButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor).isActive = true
  }

  func layoutForSearchController() {
    addSubview(searchTextField)
    addSubview(cancelButton)

    searchTextField.anchor(
      top: topAnchor,
      leading: leadingAnchor,
      bottom: nil,
      trailing: cancelButton.leadingAnchor,
      padding: .init(top: 54, left: 15, bottom: 0, right: 15),
      size: .init(width: 0, height: 40)
    )

    cancelButton.anchor(
      top: nil,
      leading: nil,
      bottom: nil,
      trailing: trailingAnchor,
      padding: .init(top: 0, left: 0, bottom: 0, right: 12)
    )
    cancelButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor).isActive = true
  }

  @objc
  func handleEditingChanged(textField: UITextField) {
    if textField.text?.count == 0 {
//            setTextFieldWithoutBack()
    } else {
//            setTextFieldWithBack()
    }
  }

  // MARK: Private

//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        setTextFieldWithBack()
//        return true
//    }
//
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        setTextFieldWithoutBack()
//        return true
//    }

  private func insertGradientBackground() {
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
    layer.frame = .init(x: 0, y: 0, width: 600, height: frame.height)
    layer.position = center
    self.layer.insertSublayer(layer, at: 0)
  }

//    func setTextFieldWithoutBack() {
//        backButton.isHidden = true
//        anchorConstraint.leading?.constant = 15
//    }
//
//    func setTextFieldWithBack() {
//        backButton.isHidden = false
//        anchorConstraint.leading?.constant = 12 + 12 + 24
//    }
}

//
//  ViewController.swift
//  bsuser
//
//  Created by Khoa Le on 10/10/2020.
//

import UIKit

final class SignUpViewController: UIViewController {

  // MARK: Internal

  @IBOutlet var nameView: UIView!
  @IBOutlet var emailView: UIView!
  @IBOutlet var passwordView: UIView!
  @IBOutlet var signUpButton: UIButton!
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var nameTextfield: UITextField!
  @IBOutlet var emailLabel: UILabel!
  @IBOutlet var emailTextfield: UITextField!
  @IBOutlet var passwordLabel: UILabel!
  @IBOutlet var passwordTextfield: UITextField!
  @IBOutlet var overallStackView: UIStackView!

  // MARK: - View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = Styles.Colors.background.color

    setupLayout()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillShow),
      name: UIResponder.keyboardWillShowNotification,
      object: nil
    )
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillHide),
      name: UIResponder.keyboardWillHideNotification,
      object: nil
    )
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewDidAppear(animated)

    NotificationCenter.default.removeObserver(
      self,
      name: UIResponder.keyboardWillShowNotification,
      object: nil
    )
    NotificationCenter.default.removeObserver(
      self,
      name: UIResponder.keyboardWillHideNotification,
      object: nil
    )
  }

  override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
    view.endEditing(true)
  }

  // MARK: Private

  @IBAction
  private func didTappedSignupButton(_: Any) {}

  @IBAction
  private func didTappedGoToLoginButton(_: Any) {
    dismiss(animated: true)
  }

  @objc
  private func keyboardWillShow(notification: Notification) {
    guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
    else { return }
    // figure out how tall the gap is from the register button to the bottom of the screen
    let keyboardFrame = value.cgRectValue
    let bottomSpace = view.frame.height - overallStackView.frame.origin.y - overallStackView.frame.height
    let difference = keyboardFrame.height - bottomSpace
    view.transform = CGAffineTransform(translationX: 0, y: -difference - 16)
  }

  @objc
  private func keyboardWillHide() {
    UIView.animate(
      withDuration: 0.5,
      delay: 0,
      usingSpringWithDamping: 1,
      initialSpringVelocity: 1,
      options: .curveEaseOut,
      animations: {
        self.view.transform = .identity
      }
    )
  }

  private func setupLayout() {
    nameLabel.isHidden = true
    emailLabel.isHidden = true
    passwordLabel.isHidden = true

    nameView.setTextfieldStyle()
    emailView.setTextfieldStyle()
    passwordView.setTextfieldStyle()

    nameTextfield.addTarget(
      self,
      action: #selector(textFieldEditingChanged),
      for: .editingChanged
    )
    emailTextfield.addTarget(
      self,
      action: #selector(textFieldEditingChanged),
      for: .editingChanged
    )
    passwordTextfield.addTarget(
      self,
      action: #selector(textFieldEditingChanged),
      for: .editingChanged
    )
  }

  @objc
  private func textFieldEditingChanged(_ textField: UITextField) {
    if textField == nameTextfield {
      nameLabel.isHidden = nameTextfield.text?.count == 0 ? true : false
    } else if textField == emailTextfield {
      emailLabel.isHidden = emailTextfield.text?.count == 0 ? true : false
    } else if textField == passwordTextfield {
      passwordLabel.isHidden = passwordTextfield.text?.count == 0 ? true : false
    }
  }
}

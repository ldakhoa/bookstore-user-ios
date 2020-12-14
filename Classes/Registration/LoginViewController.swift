//
//  LoginViewController.swift
//  bsuser
//
//  Created by Khoa Le on 11/10/2020.
//

import JGProgressHUD
import UIKit

// MARK: - LoginViewController

final class LoginViewController: UIViewController {

  // MARK: Internal

  @IBOutlet var emailView: UIView!
  @IBOutlet var passwordView: UIView!
  @IBOutlet var emailTextfield: CustomSkyFloatingLabelTextField!
  @IBOutlet var passwordTextfield: CustomSkyFloatingLabelTextField!
  @IBOutlet var loginButton: IBooksButton!
  @IBOutlet var overallStackView: UIStackView!
  @IBOutlet weak var fieldView: UIView!
  @IBOutlet weak var separatedFieldView: UIView!

//  var selectedIndex: Int?
  var isInBookDetail: Bool = false

  let hud = JGProgressHUD(style: .dark)

  // MARK: - View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = Styles.Colors.White.normal

    setupLayout()

    emailTextfield.text = AppSecurity.shared.email
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    AppSetting.shared.logout()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewDidAppear(animated)

    passwordTextfield.text = ""
  }

  override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
    view.endEditing(true)
  }

  // MARK: Fileprivate

  fileprivate func setupLayout() {
    let borderView = UIView()
    borderView.layer.borderColor = Styles.Colors.gray.color.cgColor
    borderView.layer.borderWidth = 1
    borderView.layer.cornerRadius = 8
    borderView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    borderView.frame = fieldView.bounds
    borderView.isUserInteractionEnabled = false
    fieldView.addSubview(borderView)
    fieldView.layer.cornerRadius = 8

    emailView.layer.borderColor = Styles.Colors.black.color.cgColor
    emailView.layer.borderWidth = 0
    emailView.layer.cornerRadius = 8

    passwordView.layer.borderColor = Styles.Colors.black.color.cgColor
    passwordView.layer.borderWidth = 0
    passwordView.layer.cornerRadius = 8

    emailTextfield.addTarget(
      self,
      action: #selector(editingDidBegin),
      for: .editingDidBegin
    )
    passwordTextfield.addTarget(
      self,
      action: #selector(editingDidBegin),
      for: .editingDidBegin
    )

    emailTextfield.addTarget(
      self,
      action: #selector(textFieldDidEditing),
      for: .editingChanged
    )
    passwordTextfield.addTarget(
      self,
      action: #selector(textFieldDidEditing),
      for: .editingChanged
    )
  }

  // MARK: Private

  private func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
  }

  @IBAction
  private func didTappedDismissButton(_ sender: Any) {
    dismiss(animated: true)
  }

  @IBAction
  private func handleLogin(_: Any) {
    hud.textLabel.text = "Logging in"
    hud.show(in: view)
    guard let emailText = emailTextfield.text, let passwordText = passwordTextfield.text else { return }
    NetworkManagement.login(email: emailText, password: passwordText) { code, data in
      if code == ResponseCode.ok.rawValue {
        AppSecurity.shared.userID = data["user"]["id"].int
        AppSecurity.shared.email = emailText
        AppSecurity.shared.isUserInfoExist = true
        AppSecurity.shared.isAuthorized = true
        if self.isInBookDetail {
          self.dismiss(animated: true)
        }
        AppSetting.shared.getMainController()
        self.hud.dismiss()
        Log.debug("Login response \(data)")
      } else {
        self.presentErrorAlert(with: data)
        self.hud.dismiss()
      }
    }
  }

  @objc
  private func editingDidBegin(_ textField: UITextField) {
    guard let emailField = emailTextfield.text,
          let passwordField = passwordTextfield.text else { return }
    if textField == emailTextfield {
      emailView.layer.borderWidth = 2
      passwordView.layer.borderWidth = 0
      separatedFieldView.isHidden = true
    } else if textField == passwordTextfield {
      emailView.layer.borderWidth = 0
      passwordView.layer.borderWidth = 2
      separatedFieldView.isHidden = true
    }
    checkFormValidity(emailField: emailField, passwordField: passwordField)
  }

  @objc
  private func textFieldDidEditing(_ textField: UITextField) {
    guard let emailField = emailTextfield.text,
          let passwordField = passwordTextfield.text else { return }
    checkFormValidity(emailField: emailField, passwordField: passwordField)
  }

  private func checkFormValidity(emailField: String, passwordField: String) {
    let isValid = !emailField.isEmpty && passwordField.count >= 6 && isValidEmail(emailField)
    isValid ? loginButton.setActiveStyles() : loginButton.setInactiveStyles()
  }

}

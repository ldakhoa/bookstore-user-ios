//
//  LoginViewController.swift
//  bsuser
//
//  Created by Khoa Le on 11/10/2020.
//

import JGProgressHUD
import UIKit

final class LoginViewController: UIViewController {

    // MARK: Internal

    @IBOutlet var emailView: UIView!
    @IBOutlet var passwordView: UIView!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var loginButton: IBooksButton!
    @IBOutlet weak var overallStackView: UIStackView!

    let hud = JGProgressHUD(style: .dark)

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Styles.Colors.background.color

        setupLayout()

        emailTextfield.text = AppSecurity.shared.email
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        AppSetting.shared.logout()

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

        passwordTextfield.text = ""
    }

    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        view.endEditing(true)
    }

    // MARK: Fileprivate

    fileprivate func setupLayout() {
        emailLabel.isHidden = true
        passwordLabel.isHidden = true

        emailView.setTextfieldStyle()
        passwordView.setTextfieldStyle()

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

    // MARK: Private

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
                AppSetting.shared.getMainController()
                self.hud.dismiss()
                Log.debug("Login response \(data)")
            } else {
                let message = data["message"].stringValue
                let alert = UIAlertController.configured(
                    title: "",
                    message: message,
                    preferredStyle: .alert
                )
                alert.addAction(AlertAction.ok())
                self.present(alert, animated: true)
                self.hud.dismiss()
            }
        }
    }

    @IBAction
    private func handleGoToSignup(_: Any) {
        let signupVC = AppSetting.Storyboards.Registration.signup
        signupVC.modalPresentationStyle = .fullScreen
        present(signupVC, animated: true)
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

    @objc
    private func textFieldEditingChanged(_ textField: UITextField) {
        guard let emailField = emailTextfield.text,
            let passwordField = passwordTextfield.text else { return }
        if textField == emailTextfield {
            emailLabel.isHidden = emailTextfield.text?.count == 0 ? true : false
        } else if textField == passwordTextfield {
            passwordLabel.isHidden = passwordTextfield.text?.count == 0 ? true : false
        }
        checkFormValidity(emailField: emailField, passwordField: passwordField)
    }

    private func checkFormValidity(emailField: String, passwordField: String) {
        // TODO: - Valid email by regex
        let isValid = !emailField.isEmpty && passwordField.count >= 6
        isValid ? loginButton.setActiveStyles() : loginButton.setInactiveStyles()
    }

}

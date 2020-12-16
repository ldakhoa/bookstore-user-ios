//
//  OrderAddPaymentMethod.swift
//  bsuser
//
//  Created by Khoa Le on 30/10/2020.
//

import UIKit

extension Collection {
  public func chunk(n: Int) -> [SubSequence] {
    var res: [SubSequence] = []
    var i = startIndex
    var j: Index
    while i != endIndex {
      j = index(i, offsetBy: n, limitedBy: endIndex) ?? endIndex
      res.append(self[i..<j])
      i = j
    }
    return res
  }
}

extension String {
  func chunkFormatted(
    withChunkSize chunkSize: Int = 4,
    withSeparator separator: Character = " "
  ) -> String {
    filter { $0 != separator }
      .chunk(n: chunkSize)
      .map { String($0) }
      .joined(separator: String(separator))
  }

  func trim() -> String {
    trimmingCharacters(in: CharacterSet.whitespaces)
      .trimmingCharacters(in: CharacterSet.controlCharacters)
  }
}

// MARK: - OrderAddCardDetailsControllerDelegate

protocol OrderAddCardDetailsControllerDelegate: AnyObject {
  func didTappedNext()
}

// MARK: - OrderAddCardDetailsController

final class OrderAddCardDetailsController: UIViewController, UITextFieldDelegate {

  // MARK: Internal

  @IBOutlet var nextButton: UIButton!
  @IBOutlet var cardNumberTextField: CardTextField!
  @IBOutlet var expirationTextField: CardTextField!
  @IBOutlet var cvvTextField: CardTextField!
  @IBOutlet weak var errorLabel: UILabel!
  @IBOutlet var zipCodeTextField: CardTextField!

  weak var delegate: OrderAddCardDetailsControllerDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()

    cardNumberTextField.delegate = self
    expirationTextField.delegate = self
    cvvTextField.delegate = self
    zipCodeTextField.delegate = self

  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    cardNumberTextField.becomeFirstResponder()
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

  func textFieldDidEndEditing(_ textField: UITextField) {
    if textField == cardNumberTextField {
      if cardNumberTextField.text ?? "" != "4242 4242 4242 4242" {
        errorLabel.isHidden = false
      } else {
        errorLabel.isHidden = true
      }
    }
  }

  override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
    view.endEditing(true)
  }

  func textField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String
  ) -> Bool {
    if textField == cardNumberTextField {
      let maxNumberOfCharacters = 16
      guard string.compactMap({ Int(String($0)) }).count ==
        string.count else { return false }

      let text = textField.text ?? ""

      if string.count == 0 {
        textField.text = String(text.dropLast()).chunkFormatted()
      } else {
        let newText = String((text + string)
          .filter({ $0 != " " })
          .prefix(maxNumberOfCharacters))
        textField.text = newText.chunkFormatted()
      }
      return false
    } else if textField == expirationTextField {
      let maxNumberOfCharacters = 4
      guard string.compactMap({ Int(String($0)) }).count ==
        string.count else { return false }

      let text = textField.text ?? ""

      if string.count == 0 {
        textField.text = String(text.dropLast()).chunkFormatted(withChunkSize: 2, withSeparator: "/")
      } else {
        let newText = String((text + string)
          .filter({ $0 != "/" })
          .prefix(maxNumberOfCharacters))
        textField.text = newText.chunkFormatted(withChunkSize: 2, withSeparator: "/")
      }
      return false

    } else if textField == cvvTextField {
      guard let text = textField.text else { return true }
      let newLength = text.count + string.count - range.length
      return newLength <= 3
    } else if textField == zipCodeTextField {
      guard let text = textField.text else { return true }
      let newLength = text.count + string.count - range.length
      return newLength <= 6
    }

    return false
  }

  // MARK: Private

  private func checkValidNextButton() {
    guard let cardText = cardNumberTextField.text,
          let expirationText = expirationTextField.text,
          let cvvText = cvvTextField.text,
          let zipText = zipCodeTextField.text else { return }
    let valid = cardText.count > 12
      && expirationText.count > 3
      && cvvText.count > 2
      && zipText.count > 1
    if !valid {
      let alert = UIAlertController.configured(
        title: "Please fill all fields",
        message: "We need your card to process order",
        preferredStyle: .alert
      )
      alert.addAction(AlertAction.ok())
      present(alert, animated: true)
    }
  }

  @objc
  private func keyboardWillShow(notification: Notification) {
    guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
    else { return }
    // figure out how tall the gap is from the register button to the bottom of the screen
    let keyboardFrame = value.cgRectValue
    let bottomSpace = view.frame.height - nextButton.frame.origin.y - nextButton.frame.height
    let difference = keyboardFrame.height - bottomSpace
    nextButton.transform = CGAffineTransform(translationX: 0, y: -difference - 16)
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
        self.nextButton.transform = .identity
      }
    )
  }

  @IBAction
  private func didTappedNextButton(_ sender: Any) {
    checkValidNextButton()

    delegate?.didTappedNext()
    navigationController?.popViewController(animated: true)
  }

  @IBAction
  private func didTappedDismissButton(_: Any) {
    view.endEditing(true)
    navigationController?.popViewController(animated: true)
  }
}

//
//  OrderAddPaymentMethod.swift
//  bsuser
//
//  Created by Khoa Le on 30/10/2020.
//

import UIKit

final class OrderAddCardDetailsController: UIViewController {

    // MARK: Internal

    @IBOutlet var nextButton: UIButton!
    @IBOutlet var cardNumberTextField: CardTextField!
    @IBOutlet var expirationTextField: CardTextField!
    @IBOutlet var cvvTextField: CardTextField!
    @IBOutlet var zipCodeTextField: CardTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
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

    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        view.endEditing(true)
    }

    // MARK: Private

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
    private func didTappedDismissButton(_: Any) {
        view.endEditing(true)
        navigationController?.popViewController(animated: true)
    }
}

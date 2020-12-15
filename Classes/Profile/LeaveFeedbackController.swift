//
//  LeaveFeedbackController.swift
//  bsuser
//
//  Created by Khoa Le on 13/12/2020.
//

import Cosmos
import JGProgressHUD
import UIKit

final class LeaveFeedbackController: UIViewController, UITextViewDelegate {

  // MARK: Internal

  @IBOutlet weak var leaveFeedbackButton: UIButton!
  @IBOutlet weak var ratingsView: CosmosView!
  @IBOutlet weak var textView: UITextView!
  var book: Book?

  override func viewDidLoad() {
    super.viewDidLoad()

    textView.layer.cornerRadius = 8
    textView.layer.borderWidth = 1
    textView.layer.borderColor = Styles.Colors.gray.color.cgColor
    textView.becomeFirstResponder()
    textView.delegate = self
  }

  func textViewDidChange(_ textView: UITextView) {
    if textView.text.count > 20 {
      leaveFeedbackButton.isEnabled = true
      leaveFeedbackButton.backgroundColor = Styles.Colors.primary.color
    } else {
      leaveFeedbackButton.isEnabled = false
      leaveFeedbackButton.backgroundColor = Styles.Colors.gray.color
    }
  }

  // MARK: Private

  @IBAction
  private func didTapLeaveFeedbackButton(_ sender: Any) {
    let alert = UIAlertController.configured(
      title: "Submit a reviews?",
      message: "",
      preferredStyle: .alert
    )
    alert.addActions([
      AlertAction.cancel(),
      AlertAction(AlertActionBuilder {
        $0.title = "Submit"
        $0.style = .default
      }).get { [weak self] _ in
        self?.postAReview()
      },
    ])
    present(alert, animated: true)
  }

  private func postAReview() {
    let hud = JGProgressHUD(style: .dark)
    hud.show(in: view)
    guard let content = textView.text else { return }
    if !isValidTextView(content) {
      let alert = UIAlertController.configured(
        title: "Failed to submit",
        message: "Make sure your review text greater than 20 characters, and only contains numbers and characters!",
        preferredStyle: .alert
      )
      alert.addAction(AlertAction.ok())
      hud.dismiss()
      return
    }

    NetworkManagement.postReviewByBook(
      id: book?.id ?? -1,
      with: content,
      ratings: Int(ratingsView.rating)
    ) { code, data in
      if code == ResponseCode.ok.rawValue {
        hud.textLabel.text = "Submitted"
        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
        hud.show(in: self.view)
        hud.dismiss(afterDelay: 1.0, animated: true) {
          self.dismiss(animated: true)
        }
      } else {
        self.presentErrorAlert(with: data)
        hud.dismiss()
      }
    }
  }

  private func isValidTextView(_ text: String) -> Bool {
    let regEx = ".*[^A-Za-z0-9 ].*"

    let textPred = NSPredicate(format:"SELF MATCHES %@", regEx)
    return textPred.evaluate(with: text)
  }

  @IBAction
  private func didTappedDismissButton(_ sender: Any) {
    dismiss(animated: true)
  }

}

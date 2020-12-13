//
//  LeaveFeedbackController.swift
//  bsuser
//
//  Created by Khoa Le on 13/12/2020.
//

import UIKit

final class LeaveFeedbackController: UIViewController {

  // MARK: Internal

  @IBOutlet weak var textView: UITextView!

  override func viewDidLoad() {
    super.viewDidLoad()

    textView.layer.cornerRadius = 8
    textView.layer.borderWidth = 1
    textView.layer.borderColor = Styles.Colors.gray.color.cgColor
    textView.becomeFirstResponder()
  }

  // MARK: Private

  @IBAction
  private func didTapLeaveFeedbackButton(_ sender: Any) {
  }

  @IBAction
  private func didTappedDismissButton(_ sender: Any) {
    dismiss(animated: true)
  }

}

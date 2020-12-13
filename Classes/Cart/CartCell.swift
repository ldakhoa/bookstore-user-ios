//
//  CartCell.swift
//  bsuser
//
//  Created by Khoa Le on 26/10/2020.
//

import JGProgressHUD
import UIKit

// MARK: - CartCellDelegate

protocol CartCellDelegate: AnyObject {
  func didFinishedTapUpdateAmountButton()
  func shouldDismissHUD()
  func shouldShowError(_ errString: String)
}

// MARK: - CartCell

final class CartCell: UITableViewCell {

  // MARK: Internal

  @IBOutlet var bookImageView: UIImageView!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var authorLabel: UILabel!
  @IBOutlet var priceLabel: UILabel!
  @IBOutlet var bookAmountLabel: UILabel!
  @IBOutlet var decreaseButton: UIButton!
  @IBOutlet var increaseButton: UIButton!
  @IBOutlet weak var deleteButton: UIButton!

  let hud = JGProgressHUD(style: .dark)
  var quantity: Int?

  weak var delegate: CartCellDelegate?

  var book: Book? {
    didSet {
      guard let book = book else { return }
      titleLabel.text = book.title
      priceLabel.text = "$\(book.price)"
      bookAmountLabel.text = "\(book.quantity)"
      self.quantity = book.quantity
      var authorNames = [String]()
      book.authors.forEach {
        authorNames.append($0.name)
      }
      authorLabel.text = "by \(authorNames.joined(separator: ", "))"

      if let url = URL(string: book.imageUrl) {
        bookImageView.sd_setImage(with: url)
      }
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    increaseButton.addTarget(self, action: #selector(didTappedIncreaseButton), for: .touchUpInside)

    decreaseButton.addTarget(self, action: #selector(didTappedDecreaseButton), for: .touchUpInside)
  }

  // MARK: Private

  @objc
  private func didTappedIncreaseButton() {
    if quantity ?? 1 <= 10 {
      quantity? += 1
    }
    updateQuantity(quantity ?? 1, isIncreased: true)
  }

  @objc
  private func didTappedDecreaseButton() {
    if quantity ?? 1 >= 0 {
      quantity? -= 1
    }
    updateQuantity(quantity ?? 1, isIncreased: false)
  }

  private func updateQuantity(_ quantity: Int, isIncreased: Bool) {
    delegate?.didFinishedTapUpdateAmountButton()
    NetworkManagement.putQuantityOfBookByUser(
      id: AppSecurity.shared.userID,
      at: book?.id ?? 0,
      quantity: quantity
    ) { code, data in
      if code == ResponseCode.ok.rawValue {
        self.bookAmountLabel.text = "\(self.quantity ?? 1)"
        self.delegate?.shouldDismissHUD()
      } else {
        let errMessage = data["message"].stringValue
        if isIncreased {
          self.quantity? -= 1
        } else {
          self.quantity? += 1
        }
        self.delegate?.shouldShowError(errMessage)
      }
    }
  }
}

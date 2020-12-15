//
//  BookDetailDescriptionCell.swift
//  bsuser
//
//  Created by Khoa Le on 23/10/2020.
//

import UIKit

final class BookDetailDescriptionCell: UITableViewCell {
  @IBOutlet var descriptionLabel: UILabel!

  var book: Book? {
    didSet {
      descriptionLabel.text = book?.description
    }
  }


  override func awakeFromNib() {
    super.awakeFromNib()
  }
}

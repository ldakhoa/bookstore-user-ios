//
//  BookDetailMainCell.swift
//  bsuser
//
//  Created by Khoa Le on 22/10/2020.
//

import UIKit
import Cosmos

final class BookDetailMainCell: UITableViewCell {

    var book: Book? {
        didSet {
            guard let book = book,
                  let imageUrl = URL(string: book.imageUrl) else { return }
            bookTitleLabel.text = book.title
            authorLabel.text = book.author
            ratingsView.rating = book.ratings
            ratingsView.text = "\(book.numberOfRatings)"
            priceLabel.text = "$\(book.price)"
            bookImageView.sd_setImage(with: imageUrl)
        }
    }

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var ratingsView: CosmosView!
    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

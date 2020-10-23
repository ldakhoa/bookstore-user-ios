//
//  BookDetailMainCell.swift
//  bsuser
//
//  Created by Khoa Le on 22/10/2020.
//

import Cosmos
import UIKit

final class BookDetailMainCell: UITableViewCell {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var ratingsView: CosmosView!
    @IBOutlet weak var priceLabel: UILabel!

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

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

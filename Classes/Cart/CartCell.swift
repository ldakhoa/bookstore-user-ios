//
//  CartCell.swift
//  bsuser
//
//  Created by Khoa Le on 26/10/2020.
//

import UIKit

final class CartCell: UITableViewCell {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var bookAmountLabel: UILabel!
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

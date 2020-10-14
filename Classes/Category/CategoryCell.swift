//
//  CategoryCell.swift
//  bsuser
//
//  Created by Khoa Le on 12/10/2020.
//

import UIKit

final class CategoryCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = Styles.Colors.background.color
    }
}

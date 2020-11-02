//
//  ProfileCell.swift
//  bsuser
//
//  Created by Khoa Le on 11/10/2020.
//

import UIKit

final class ProfileCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = Styles.Colors.background.color
    }
}

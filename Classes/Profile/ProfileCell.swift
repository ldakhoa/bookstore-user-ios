//
//  ProfileCell.swift
//  bsuser
//
//  Created by Khoa Le on 11/10/2020.
//

import UIKit

final class ProfileCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = Styles.Colors.background.color
    }
}

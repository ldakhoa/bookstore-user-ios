//
//  LocationTopView.swift
//  bsuser
//
//  Created by Khoa Le on 11/10/2020.
//

import UIKit

class LocationTopView: UIView {
    let locationLabel = UILabel(
        text: "Delivery to Khoa - Ho Chi Minh 700000",
        font: Styles.Text.location.preferredFont,
        textColor: UIColor.black,
        numberOfLines: 1
    )
    let imageView = UIImageView(image: #imageLiteral(resourceName: "location"))

    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = Styles.Colors.locationBackground.color
        let stackview = UIStackView(arrangedSubviews: [imageView, locationLabel])
        stackview.axis = .horizontal

        stackview.spacing = 8

        addSubview(stackview)
        stackview.anchor(
            top: nil,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 0, left: 15, bottom: 0, right: 15)
        )
        imageView.constrainHeight(24)
        imageView.constrainWidth(24)
        stackview.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}

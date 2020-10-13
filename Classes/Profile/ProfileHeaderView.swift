//
//  ProfileHeaderView.swift
//  bsuser
//
//  Created by Khoa Le on 11/10/2020.
//

import UIKit

class ProfileHeaderView: UIView {
    let nameLabel = UILabel(
        text: "Khoa Le",
        font: Styles.Text.h3.preferredFont,
        textColor: Styles.Colors.black.color
    )
    let profileImageView = UIImageView(image: #imageLiteral(resourceName: "avatar"))
    let showProfileButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 64 / 2
        profileImageView.clipsToBounds = true


        showProfileButton.setTitle("Show profile", for: .normal)
        showProfileButton.setTitleColor(Styles.Colors.darkGreen.color, for: .normal)
        let infoStackview = UIStackView(arrangedSubviews: [nameLabel, showProfileButton])
        infoStackview.axis = .vertical
        infoStackview.alignment = .leading
        infoStackview.spacing = -4

        addSubview(profileImageView)
        addSubview(infoStackview)

        profileImageView.anchor(
            top: nil,
            leading: leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 0, left: 18, bottom: 0, right: 0),
            size: .init(width: 64, height: 64)
        )
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        infoStackview.anchor(
            top: nil,
            leading: profileImageView.trailingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 0, left: 18, bottom: 0, right: 18)
        )
        infoStackview.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

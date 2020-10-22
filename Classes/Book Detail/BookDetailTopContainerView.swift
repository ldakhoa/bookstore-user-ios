//
//  BookDetailTopContainerView.swift
//  bsuser
//
//  Created by Khoa Le on 22/10/2020.
//

import UIKit

final class BookDetailTopContainerView: UIView {

    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        favoriteImageView.contentMode = .scaleAspectFill
        dismissImageView.contentMode = .scaleAspectFill

        backgroundColor = Styles.Colors.White.normal
        setupLayer()

        addSubview(dismissImageView)
        addSubview(favoriteImageView)

        dismissImageView.anchor(
            top: nil,
            leading: leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 0, left: 16, bottom: 0, right: 0),
            size: .init(width: 15, height: 15)
        )
        dismissImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        favoriteImageView.anchor(
            top: nil,
            leading: nil,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 16),
            size: .init(width: 16, height: 16)
        )
        favoriteImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    let favoriteImageView = UIImageView(image: #imageLiteral(resourceName: "favorite_border"))
    let dismissImageView = UIImageView(image: #imageLiteral(resourceName: "dismiss"))

    // MARK: Private

    private func setupLayer() {
        let bottomLayer = CALayer()
        bottomLayer.frame = .init(x: 0, y: Styles.Sizes.heightTopView, width: 1000, height: 1)
        bottomLayer.backgroundColor = Styles.Colors.separate.color.cgColor
        layer.addSublayer(bottomLayer)
    }

}

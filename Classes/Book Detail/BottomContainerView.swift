//
//  BottomContainerView.swift
//  bsuser
//
//  Created by Khoa Le on 22/10/2020.
//

import UIKit

final class BookDetailBottomContainerView: UIView {
    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        let imageView = UIImageView(image: #imageLiteral(resourceName: "cart"))
        imageView.contentMode = .scaleAspectFill

        backgroundColor = Styles.Colors.White.normal
        setupLayer()

        addSubview(buyNowButton)

        buyNowButton.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 12, left: 24, bottom: 0, right: 24),
            size: .init(width: 0, height: 50)
        )
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    let buyNowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add to Cart", for: .normal)
        button.setTitleColor(Styles.Colors.White.normal, for: .normal)
        button.titleLabel?.font = Styles.Text.cartButton.preferredFont
        button.layer.cornerRadius = 8
        button.backgroundColor = Styles.Colors.primary.color
        button.setupShadow(
            opacity: 0.05,
            radius: 8,
            offset: .init(width: 0, height: 0),
            color: Styles.Colors.primary.color
        )
        return button
    }()

    // MARK: Private

    private func setupLayer() {
        let bottomLayer = CALayer()
        bottomLayer.frame = .init(x: 0, y: 0, width: 1000, height: 1)
        bottomLayer.backgroundColor = Styles.Colors.separate.color.cgColor
        layer.addSublayer(bottomLayer)
    }
}

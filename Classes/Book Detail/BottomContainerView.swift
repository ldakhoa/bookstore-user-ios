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

        addSubview(addToCartView)
        addSubview(buyNowButton)

        addToCartView.addSubview(imageView)
        addToCartView.addSubview(cartLabel)

        imageView.anchor(
            top: addToCartView.topAnchor,
            leading: nil,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 8, left: 0, bottom: 0, right: 0),
            size: .init(width: 20, height: 20)
        )
        imageView.centerXAnchor.constraint(equalTo: addToCartView.centerXAnchor).isActive = true

        cartLabel.anchor(
            top: imageView.bottomAnchor,
            leading: nil,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 4, left: 0, bottom: 0, right: 0)
        )
        cartLabel.centerXAnchor.constraint(equalTo: addToCartView.centerXAnchor).isActive = true

        addToCartView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 12, left: 12, bottom: 0, right: 0),
            size: .init(width: 50, height: 50)
        )

        buyNowButton.anchor(
            top: topAnchor,
            leading: addToCartView.trailingAnchor,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 12, left: 12, bottom: 0, right: 12),
            size: .init(width: 0, height: 50)
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    let addToCartView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderColor = Styles.Colors.darkGreen.color.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = Styles.Colors.White.normal
        return view
    }()

    let buyNowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Buy Now", for: .normal)
        button.setTitleColor(Styles.Colors.White.normal, for: .normal)
        button.titleLabel?.font = Styles.Text.subhealine.preferredFont
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

    private let cartLabel = UILabel(
        text: "Cart",
        font: Styles.Text.cart.preferredFont,
        textColor: Styles.Colors.darkGreen.color,
        textAlignment: .center
    )

    private func setupLayer() {
        let bottomLayer = CALayer()
        bottomLayer.frame = .init(x: 0, y: 0, width: 1000, height: 1)
        bottomLayer.backgroundColor = Styles.Colors.separate.color.cgColor
        layer.addSublayer(bottomLayer)
    }

}

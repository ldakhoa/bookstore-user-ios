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

//        backgroundColor = Styles.Colors.White.normal
//        backgroundColor = Styles.Colors.black.color
        backgroundColor = .clear
        setupLayer()

        addSubview(dismissView)
        addSubview(favoriteView)
        addSubview(cartView)

        dismissView.anchor(
            top: nil,
            leading: leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: .init(top: 0, left: 16, bottom: 0, right: 0),
            size: .init(
                width: Styles.Sizes.bookDetailtopViewSize,
                height: Styles.Sizes.bookDetailtopViewSize
            )
        )
        dismissView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        favoriteView.anchor(
            top: nil,
            leading: nil,
            bottom: nil,
            trailing: trailingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 16),
            size: .init(
                width: Styles.Sizes.bookDetailtopViewSize,
                height: Styles.Sizes.bookDetailtopViewSize
            )
        )
        favoriteView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        cartView.anchor(
            top: nil,
            leading: nil,
            bottom: nil,
            trailing: favoriteView.leadingAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 16),
            size: .init(
                width: Styles.Sizes.bookDetailtopViewSize,
                height: Styles.Sizes.bookDetailtopViewSize
            )
        )
        cartView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    let favoriteView = createView(with: #imageLiteral(resourceName: "favorite_border"), size: 16)
    let dismissView = createView(with: #imageLiteral(resourceName: "dismiss"), size: 13)
    let cartView = createView(with: #imageLiteral(resourceName: "cart-top"), size: 17)
    let bottomLayer = CALayer()

    // MARK: Private

    private static func createView(with image: UIImage, size: CGFloat) -> UIView {
        let iv = UIImageView(image: image)
        iv.constrainWidth(size)
        iv.constrainHeight(size)
        iv.contentMode = .scaleAspectFit

        let containerView = UIView()
        containerView.backgroundColor = Styles.Colors.White.normal
        containerView.layer.cornerRadius = Styles.Sizes.bookDetailtopViewSize / 2
        containerView.addSubview(iv)
        iv.centerInSuperview()
        return containerView
    }

    private func setupLayer() {

        bottomLayer.frame = .init(x: 0, y: Styles.Sizes.heightTopView, width: 1000, height: 1)
        bottomLayer.backgroundColor = Styles.Colors.separate.color.withAlphaComponent(0.0).cgColor
        layer.addSublayer(bottomLayer)
    }

}

extension UIView {
    func toTopViewShadow(opacity: Float) {
        setupShadow(
            opacity: opacity,
            radius: 8,
            offset: .init(width: 0, height: 1),
            color: Styles.Colors.black.color
        )
    }
}

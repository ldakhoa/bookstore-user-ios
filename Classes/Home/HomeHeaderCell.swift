//
//  ReviewHeaderCell.swift
//  bsuser
//
//  Created by Khoa Le on 14/12/2020.
//

import UIKit

// MARK: - HeaderView

class HeaderView: UIView {

  // MARK: Lifecycle

  override init(frame: CGRect) {
    super.init(frame: frame)

    setupGradientLayer()
    layer.cornerRadius = 8
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal

  let gradientLayer = CAGradientLayer()

  override func layoutSubviews() {
    // in here you know what your CardView frame will be
    gradientLayer.frame = frame
  }

  // MARK: Private

  private func setupGradientLayer() {
    gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
    gradientLayer.locations = [0.5, 1.1]
    gradientLayer.cornerRadius = 8
    layer.addSublayer(gradientLayer)
  }
}

// MARK: - HomeHeaderCell

final class HomeHeaderCell: UICollectionViewCell {

  // MARK: Lifecycle

  override init(frame: CGRect) {
    super.init(frame: frame)

    imageView.layer.cornerRadius = 8
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true

    addSubview(imageView)
    addSubview(headerView)
    addSubview(titleLabel)

    titleLabel.anchor(
      top: nil,
      leading: imageView.leadingAnchor,
      bottom: imageView.bottomAnchor,
      trailing: imageView.trailingAnchor,
      padding: .init(top: 0, left: 10, bottom: 12, right: 12)
    )
    imageView.fillSuperview(padding: .init(top: 8, left: 0, bottom: 4, right: 0))
    headerView.fillSuperview(padding: .init(top: 8, left: 0, bottom: 4, right: 0))

  }

  required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Internal

  let titleLabel = UILabel(
    text: "",
    font: Styles.Text.homeHeader.preferredFont,
    textColor: Styles.Colors.White.normal,
    numberOfLines: 2
  )
  let imageView = UIImageView()
  let headerView = HeaderView()

  var book: HomeHeaderBook? {
    didSet {
      titleLabel.text = book?.title
      imageView.image = book?.image
    }
  }

}

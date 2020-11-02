//
//  Styles.swift
//  bsuser
//
//  Created by Khoa Le on 10/10/2020.
//

import StyledTextKit
import UIKit

// MARK: - Styles

enum Styles {
    enum Sizes {
        static let avatar = CGSize(width: 30, height: 30)
        static let textFieldCornerRadius: CGFloat = 4
        static let buttonCornerRadius: CGFloat = 4
        static let searchCornerRadius: CGFloat = 8
        static let cellCornerRadius: CGFloat = 8
        static let heightTopView: CGFloat = 50
        static let bookDetailtopViewSize: CGFloat = 32
    }

    enum Colors {
        enum Gradient {
            static let color1 = UIColor(red: 0.859, green: 0.188, blue: 0.133, alpha: 1).cgColor
            static let color2 = UIColor(red: 0.894, green: 0.31, blue: 0.224, alpha: 1).cgColor
            static let color3 = UIColor(red: 0.925, green: 0.408, blue: 0.314, alpha: 1).cgColor
            static let color4 = UIColor(red: 0.949, green: 0.498, blue: 0.408, alpha: 1).cgColor
            static let color5 = UIColor(red: 0.973, green: 0.584, blue: 0.502, alpha: 1).cgColor
            static let color6 = UIColor(red: 0.988, green: 0.671, blue: 0.6, alpha: 1).cgColor
        }

        enum White {
            static let normal = UIColor.white
            static let whiter = UIColor(white: 0.9, alpha: 1)
        }

        static let primary = "DB3022"
        static let background = "F6F6F7"
        static let gray = "9B9B9B"
        static let darkGreen = "378095"
        static let sale = "DB3022"
        static let hot = "DB3022"
        static let success = "2AA952"
        static let error = "F01F0E"
        static let black = "000000"
        static let locationBackground = "F89580"
        static let border = "D9D9D9"
        static let background2 = "FEFFFE"
        static let lightGray = UIColor.lightGray
        static let separate = "DCDCDC"
        static let filterBorder = "CC7F3E"
        static let filterBackground = "FDF7F2"
        static let textFieldBottomLine = "F1F2F2"
    }

    enum Text {

        // MARK: Internal

        static let h1 = TextStyle(font: .name(cerealMedium), size: 34)
        static let h2 = TextStyle(font: .name(cerealMedium), size: 24)
        static let h3 = TextStyle(font: .name(cerealMedium), size: 22)
        static let subhealine = TextStyle(font: .name(cerealMedium), size: 16)
        static let headline = TextStyle(font: .name(cerealMedium), size: 34)

        static let cartButton = TextStyle(font: .name(cerealBold), size: 16)
        static let textfield = TextStyle(font: .name(cerealBook), size: 16)
        static let body = TextStyle(font: .name(cerealBook), size: 16)
        static let bodyBold = TextStyle(font: .name(cerealMedium), size: 16)
        static let titleBold = TextStyle(font: .name(cerealMedium), size: 14)
        static let title = TextStyle(font: .name(cerealBook), size: 14)
        static let cart = TextStyle(font: .name(cerealMedium), size: 12)
        static let helper = TextStyle(font: .name(cerealBook), size: 12)
        static let button = TextStyle(font: .name(cerealMedium), size: 15)
        static let location = TextStyle(font: .name(cerealMedium), size: 15)

        // MARK: Private

        private static let cerealLight = "AirbnbCerealApp-Light"
        private static let cerealBook = "AirbnbCerealApp-Book"
        private static let cerealMedium = "AirbnbCerealApp-Medium"
        private static let cerealBold = "AirbnbCerealApp-Bold"
    }
}

extension TextStyle {
    var preferredFont: UIFont {
        font(contentSizeCategory: UIContentSizeCategory.preferred)
    }

    func with(attributes: [NSAttributedString.Key: Any]) -> TextStyle {
        var newAttributes = self.attributes
        for (key, value) in attributes {
            newAttributes[key] = value
        }
        return TextStyle(
            font: font,
            size: size,
            attributes: newAttributes,
            minSize: minSize,
            maxSize: maxSize
        )
    }

    func with(foreground: UIColor? = nil, background: UIColor? = nil) -> TextStyle {
        var attributes = self.attributes
        attributes[.foregroundColor] = foreground ?? attributes[.foregroundColor]
        attributes[.backgroundColor] = background ?? attributes[.backgroundColor]
        return TextStyle(
            font: font,
            size: size,
            attributes: attributes,
            minSize: minSize,
            maxSize: maxSize
        )
    }
}

extension String {
    public var color: UIColor {
        UIColor.fromHex(self)
    }
}

extension UIContentSizeCategory {
    static let preferred: UIContentSizeCategory = UIApplication.shared.preferredContentSizeCategory
}

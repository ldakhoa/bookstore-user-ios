//
//  Styles.swift
//  bsuser
//
//  Created by Khoa Le on 10/10/2020.
//

import StyledTextKit
import UIKit

enum Styles {
    enum Sizes {
        static let avatar = CGSize(width: 30, height: 30)
        static let textFieldCornerRadius: CGFloat = 4
        static let buttonCornerRadius: CGFloat = 25
        static let searchCornerRadius: CGFloat = 8
        static let cellCornerRadius: CGFloat = 8
    }

    enum Colors {
        static let primary = "DB3022"
        static let background = "F9F9F9"
        static let gray = "9B9B9B"
        static let darkGreen = "378095"
        static let sale = "DB3022"
        static let hot = "DB3022"
        static let success = "2AA952"
        static let error = "F01F0E"
        static let black = "222222"
        static let white = UIColor.white
        static let locationBackground = "F89580"
        static let border = "D9D9D9"
        static let background2 = "FEFFFE"

        enum Gradient {
            static let color1 = UIColor(red: 0.859, green: 0.188, blue: 0.133, alpha: 1).cgColor
            static let color2 = UIColor(red: 0.894, green: 0.31, blue: 0.224, alpha: 1).cgColor
            static let color3 = UIColor(red: 0.925, green: 0.408, blue: 0.314, alpha: 1).cgColor
            static let color4 = UIColor(red: 0.949, green: 0.498, blue: 0.408, alpha: 1).cgColor
            static let color5 = UIColor(red: 0.973, green: 0.584, blue: 0.502, alpha: 1).cgColor
            static let color6 = UIColor(red: 0.988, green: 0.671, blue: 0.6, alpha: 1).cgColor
        }
    }

    enum Text {
        static let h1 = TextStyle(font: .system(.bold), size: 34)
        static let h2 = TextStyle(font: .system(.bold), size: 24)
        static let h3 = TextStyle(font: .system(.bold), size: 18)
        static let subhealine = TextStyle(font: .system(.bold), size: 16)
        static let headline = TextStyle(font: .system(.bold), size: 34)

        static let body = TextStyle(size: 16)
        static let bodyBold = TextStyle(font: .system(.bold), size: 16)
        static let titleBold = TextStyle(font: .system(.bold), size: 14)
        static let title = TextStyle(size: 14)
        static let helper = TextStyle(size: 11)
        static let button = TextStyle(font: .system(.bold), size: 15)
        static let location = TextStyle(font: .system(.bold), size: 15)

    }
}

extension TextStyle {
    var preferredFont: UIFont {
        return font(contentSizeCategory: UIContentSizeCategory.preferred)
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
        return TextStyle(font: font, size: size, attributes: attributes, minSize: minSize, maxSize: maxSize)
    }
}

extension String {
    public var color: UIColor {
        return UIColor.fromHex(self)
    }
}

extension UIContentSizeCategory {
    static let preferred: UIContentSizeCategory = UIApplication.shared.preferredContentSizeCategory
}

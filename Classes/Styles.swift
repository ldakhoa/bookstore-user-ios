//
//  Styles.swift
//  bsuser
//
//  Created by Khoa Le on 10/10/2020.
//

import UIKit
import StyledTextKit

enum Styles {

    enum Sizes {
        static let avatar = CGSize(width: 30, height: 30)
        static let textFieldCornerRadius: CGFloat = 4
    }

    enum Colors {
        static let primary = "DB3022"
        static let backgroud = "F9F9F9"
        static let gray = "9B9B9B"
        static let darkGreen = "378095"
        static let sale = "DB3022"
        static let hot = "DB3022"
        static let success = "2AA952"
        static let error = "F01F0E"
        static let black = "222222"
        static let white = UIColor.white
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
    }
}

extension TextStyle {

    var preferredFont: UIFont {
        return self.font(contentSizeCategory: UIContentSizeCategory.preferred)
    }

    func with(attributes: [NSAttributedString.Key: Any]) -> TextStyle {
        var newAttributes = self.attributes
        for (key, value) in attributes {
            newAttributes[key] = value
        }
        return TextStyle(font: font, size: size, attributes: newAttributes, minSize: minSize, maxSize: maxSize)
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

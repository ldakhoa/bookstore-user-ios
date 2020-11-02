//
//  StyledTextKit.swift
//  StyledTextKit
//
//  Created by Ryan Nystrom on 12/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import UIKit

public class StyledText: Hashable, Equatable {
    public struct ImageFitOptions: OptionSet {
        public let rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }

        public static let fit = ImageFitOptions(rawValue: 1 << 0)
        public static let center = ImageFitOptions(rawValue: 2 << 0)
    }

    public enum Storage: Hashable, Equatable {
        case text(String)
        case attributedText(NSAttributedString)
        case image(UIImage, [ImageFitOptions])

        // MARK: Hashable

        public var hashValue: Int {
            switch self {
            case let .text(text): return text.hashValue
            case let .attributedText(text): return text.hashValue
            case let .image(image, _): return image.hashValue
            }
        }

        // MARK: Equatable

        public static func == (lhs: Storage, rhs: Storage) -> Bool {
            switch lhs {
            case let .text(lhsText):
                switch rhs {
                case let .text(rhsText): return lhsText == rhsText
                case .attributedText, .image: return false
                }
            case let .attributedText(lhsText):
                switch rhs {
                case .text, .image: return false
                case let .attributedText(rhsText): return lhsText == rhsText
                }
            case let .image(lhsImage, lhsOptions):
                switch rhs {
                case .text, .attributedText: return false
                case let .image(rhsImage, rhsOptions):
                    return lhsImage == rhsImage && lhsOptions == rhsOptions
                }
            }
        }
    }

    public let storage: Storage
    public let style: TextStyle

    public init(storage: Storage = .text(""), style: TextStyle = TextStyle()) {
        self.storage = storage
        self.style = style
    }

    public convenience init(text: String, style: TextStyle = TextStyle()) {
        self.init(storage: .text(text), style: style)
    }

    internal var text: String {
        switch storage {
        case let .text(text): return text
        case let .attributedText(text): return text.string
        case .image: return ""
        }
    }

    internal func render(contentSizeCategory: UIContentSizeCategory) -> NSAttributedString {
        var attributes = style.attributes
        let font = style.font(contentSizeCategory: contentSizeCategory)
        attributes[.font] = font
        switch storage {
        case let .text(text):
            return NSAttributedString(string: text, attributes: attributes)
        case let .attributedText(text):
            guard text.length > 0 else { return text }
            let mutable = text.mutableCopy() as? NSMutableAttributedString ?? NSMutableAttributedString()
            let range = NSRange(location: 0, length: mutable.length)
            for (k, v) in attributes {
                // avoid overwriting attributes set by the stored string
                if mutable.attribute(k, at: 0, effectiveRange: nil) == nil {
                    mutable.addAttribute(k, value: v, range: range)
                }
            }
            return mutable
        case let .image(image, options):
            let attachment = NSTextAttachment()
            attachment.image = image

            var bounds = attachment.bounds
            let size = image.size
            if options.contains(.fit) {
                let ratio = size.width / size.height
                let fontHeight = min(ceil(font.pointSize), size.height)
                bounds.size.width = ratio * fontHeight
                bounds.size.height = fontHeight
            } else {
                bounds.size = size
            }

            if options.contains(.center) {
                bounds.origin.y = round((font.capHeight - bounds.height) / 2)
            }
            attachment.bounds = bounds

            // non-breaking space so the color hack doesn't wrap
            let attributedString = NSMutableAttributedString(string: "\u{00A0}")
            attributedString.append(NSAttributedString(attachment: attachment))
            // replace attributes to 0 size font so no actual space taken
            attributes[.font] = UIFont.systemFont(ofSize: 0)
            // override all attributes so color actually tints image
            attributedString.addAttributes(
                attributes,
                range: NSRange(location: 0, length: attributedString.length)
            )
            return attributedString
        }
    }

    // MARK: Hashable

    public var hashValue: Int {
        return storage
            .combineHash(with: style)
    }

    // MARK: Equatable

    public static func == (lhs: StyledText, rhs: StyledText) -> Bool {
        return lhs.storage == rhs.storage
            && lhs.style == rhs.style
    }
}

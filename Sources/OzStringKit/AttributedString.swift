//
//  AttributedString.swift
//  OzStringKit
//
//  Created by Konstantin Oznobikhin on Mar 20, 2020.
//  Copyright © 2020 Konstantin Oznobikhin. All rights reserved.
//

import Foundation

#if os(macOS)
    import AppKit
    public typealias OzImage = NSImage
    public typealias OzColor = NSColor
    public typealias OzFont = NSFont
#else
    import UIKit
    public typealias OzImage = UIImage
    public typealias OzColor = UIColor
    public typealias OzFont = UIFont
#endif

public enum LigatureUsage: Int {
    /// don't use ligatures
    case none = 0

    /// use default ligatures
    case `default` = 1

    #if os(macOS)
    /// use all ligature
    case all = 2
    #endif
}

public enum VerticalGlyphForm: Int {
    case horizontalText = 0
    case verticalText = 1
}

public enum WritingDirection: Int {
    case leftToRightEmbedding = 0
    case rightToLeftEmbedding = 1
    case leftToRightOverride = 2
    case rightToLeftOverride = 3
}

extension WritingDirection {
    public init?(direction: NSWritingDirection, format: NSWritingDirectionFormatType) {
        switch (direction, format) {
        case (.leftToRight, .embedding):
            self = .leftToRightEmbedding

        case (.rightToLeft, .embedding):
            self = .rightToLeftEmbedding

        case (.leftToRight, .override):
            self = .leftToRightOverride

        case (.rightToLeft, .override):
            self = .rightToLeftOverride

        case (.natural, _):
            return nil

        @unknown default:
            return nil
        }
    }
}

/// Creates NSAttributedString with string interpolation.
///
/// - parameter value: string interpolation with NSAttributedString attributes.
///
/// - returns: An instance of NSAttributedString with string and attributes created with the specified string interpolation.
public func attributedString(_ value: AttributedString) -> NSAttributedString {
    return value.attributedString
}

/// Provides custom string interpolation for building instances of NSAttributedString.
public struct AttributedString {
    public let attributedString: NSAttributedString
}

/// Allows AttributedString initialization with string literlals.
extension AttributedString: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.attributedString = NSAttributedString(string: value)
    }
}

/// String interpolation support for AttributedString.
extension AttributedString: ExpressibleByStringInterpolation {
    public init(stringInterpolation interpolation: StringInterpolation) {
        self.attributedString = interpolation.attributedString
    }

    /// String interpolation implementation for AttributedString.
    public struct StringInterpolation: StringInterpolationProtocol {
        var attributedString: NSMutableAttributedString

        public init(literalCapacity: Int, interpolationCount: Int) {
            self.attributedString = NSMutableAttributedString()
        }

        public mutating func appendLiteral(_ literal: String) {
            let attributedInterpolation = NSAttributedString(string: literal)
            self.attributedString.append(attributedInterpolation)
        }

        /// Appends the specified string to the NSAttributedString instance being built with interpolation.
        /// - parameter string: the string to be added.
        public mutating func appendInterpolation(_ string: String) {
            let attributedInterpolation = NSAttributedString(string: string)
            self.attributedString.append(attributedInterpolation)
        }

        /// Appends the specified attributed string to the NSAttributedString instance being built with interpolation.
        /// - parameter attributedString: the string to be added.
        public mutating func appendInterpolation(_ attributedString: NSAttributedString) {
            self.attributedString.append(attributedString)
        }

        /// Appends the specified string with the specified attributes to the NSAttributedString instance being built with interpolation.
        /// - parameter string: the string to be added.
        /// - parameter attributes: NSAttributedString attributes to be applied to the string.
        public mutating func appendInterpolation(_ string: String, attributes: [NSAttributedString.Key: Any]) {
            let attributedInterpolation = NSAttributedString(string: string, attributes: attributes)
            self.attributedString.append(attributedInterpolation)
        }

        /// Appends the specified string with the specified attributes to the NSAttributedString instance being built with interpolation.
        /// - parameter attributedString: the string to be added.
        /// - parameter attributes: NSAttributedString attributes to be applied to the string.
        public mutating func appendInterpolation(
            _ attributedString: NSAttributedString,
            attributes: [NSAttributedString.Key: Any]) {

            let attributedInterpolation = NSMutableAttributedString(attributedString: attributedString)
            let length = attributedInterpolation.length
            attributedInterpolation.addAttributes(attributes, range: NSRange(location: 0, length: length))
            self.attributedString.append(attributedInterpolation)
        }

#if !os(watchOS)
        /// Appends the specified attachment to the NSAttributedString.
        /// - parameter attachment: the attachment to be added.
        public mutating func appendInterpolation(attachment: NSTextAttachment) {
            let attachmentString = NSAttributedString(attachment: attachment)
            self.attributedString.append(attachmentString)
        }

        /// Appends the specified image as a text attachment to the NSAttributedString.
        /// - parameter image: the image to add to NSAttributedString.
        public mutating func appendInterpolation(image: OzImage) {
            self.appendInterpolation(image: image, bounds: CGRect(origin: .zero, size: image.size))
        }

        /// Appends the specified image with the specified size as a text attachment to the NSAttributedString.
        /// - parameter image: the image to add to NSAttributedString.
        /// - parameter size: defines size of image graphical representation inside NSAttributedString.
        public mutating func appendInterpolation(image: OzImage, size: CGSize) {
            self.appendInterpolation(image: image, bounds: CGRect(origin: .zero, size: size))
        }

        /// Appends the specified image as a text attachment to the NSAttributedString
        /// - parameter image: the image to add to NSAttributedString.
        /// - parameter size: defines the layout bounds of the image's graphical representation in the text coordinate system. See NSTextAttachment
        /// for more details.
        public mutating func appendInterpolation(image: OzImage, bounds: CGRect) {
            let attachment = NSTextAttachment()

            attachment.bounds = bounds
            attachment.image = image

            self.appendInterpolation(attachment: attachment)
        }
#endif

        /// Appends the specified string with the specified attributes to the NSAttributedString instance being built with interpolation.
        /// - parameter string: the string to be added.
        /// - parameter attribute: attributes to be applied to the string.
        public mutating func appendInterpolation(_ string: String, _ attribute: Attribute...) {
            self.appendInterpolation(string, attribute)
        }

        /// Appends the specified string with the specified attributes to the NSAttributedString instance being built with interpolation.
        /// - parameter string: the string to be added.
        /// - parameter attributes: array pf attributes to be applied to the string.
        public mutating func appendInterpolation(_ string: String, _ attributes: [Attribute]) {
            let attributes = self.mergeAttributes(attributes)
            self.appendInterpolation(string, attributes: attributes)
        }

        /// Appends the specified string with the specified attributes to the NSAttributedString instance being built with interpolation.
        /// - parameter attributedString: the string to be added.
        /// - parameter attribute: attributes to be applied to the string.
        public mutating func appendInterpolation(_ attributedString: NSAttributedString, _ attribute: Attribute...) {
            self.appendInterpolation(attributedString, attribute)
        }

        /// Appends the specified string with the specified attributes to the NSAttributedString instance being built with interpolation.
        /// - parameter attributedString: the string to be added.
        /// - parameter attributes: array pf attributes to be applied to the string.
        public mutating func appendInterpolation(_ attributedString: NSAttributedString, _ attributes: [Attribute]) {
            let attributes = self.mergeAttributes(attributes)
            self.appendInterpolation(attributedString, attributes: attributes)
        }
    }
}

// MARK: - common attributes
extension AttributedString {
    /// Simplifies adding inline attributes to the interpolated string.
    public struct Attribute {
        let attributes: [NSAttributedString.Key: Any]

        /// Sets the specified color as a background color for interpolation.
        /// - parameter color: the color to be used as a background.
        public static func backgroundColor(_ color: OzColor) -> Attribute {
            return .init(attributes: [.backgroundColor: color])
        }

        /// Sets the character’s offset from the baseline.
        /// - parameter value: indicates the character’s offset from the baseline, in points.
        public static func baselineOffset(_ value: CGFloat) -> Attribute {
            return .init(attributes: [.baselineOffset: value])
        }

        /// Sets the log of the expansion factor to be applied to glyphs.
        /// - parameter value: indicates the log of the expansion factor to be applied to glyphs.
        public static func expansion(_ value: CGFloat) -> Attribute {
            return .init(attributes: [.expansion: value])
        }

        /// Sets the specified font for interpolation.
        /// - parameter font: the font to be used for string.
        public static func font(_ font: OzFont) -> Attribute {
            return .init(attributes: [.font: font])
        }

        @available(*, unavailable, message: "font requires non optional Font object")
        public static func font(_ font: OzFont?) -> Attribute {
            return .init(attributes: [:])
        }

        /// Sets the specified color as a foreground color for interpolation.
        /// - parameter color: the color to be used as a foreground.
        public static func color(_ color: OzColor) -> Attribute {
            return .init(attributes: [.foregroundColor: color])
        }

        @available(*, unavailable, renamed: "color")
        public static func foregroundColor(_ color: OzColor) -> Attribute {
            return .color(color)
        }

        /// Sets the specified value to be used as the number of points by which to adjust kern-pair characters.
        /// - parameter value: the value of kerning.
        public static func kern(_ value: CGFloat) -> Attribute {
            return .init(attributes: [.kern: value])
        }

        /// Ligatures cause specific character combinations to be rendered using a single custom glyph that corresponds to those characters.
        /// - parameter value: ligatures usage.
        public static func ligature(_ value: LigatureUsage) -> Attribute {
            return .init(attributes: [.ligature: value.rawValue])
        }

        /// Sets the specified URL for interpolation.
        /// - parameter value: the URL to be added to interpolated string.
        public static func link(_ value: URL) -> Attribute {
            return .init(attributes: [.link: value])
        }

        @available(*, unavailable, message: "link requires non optional URL value")
        public static func link(_ value: URL?) -> Attribute {
            return .init(attributes: [:])
        }

        /// Sets the specified URL for interpolation.
        /// - parameter value: the URL to be added to interpolated string.
        public static func link(_ value: String) -> Attribute {
            return .init(attributes: [.link: value])
        }

        @available(*, unavailable, message: "link requires non optional URL value")
        public static func link(_ value: String?) -> Attribute {
            return .init(attributes: [:])
        }

        /// Sets the skew to be applied to glyphs in interpolation.
        /// - parameter value: the skew value.
        public static func obliqueness(_ value: Double) -> Attribute {
            return .init(attributes: [.obliqueness: value])
        }

        /// Sets the shadow to be used in interpolation.
        /// - parameter shadow: the object specifying shadow settings.
        public static func shadow(_ shadow: NSShadow) -> Attribute {
            return .init(attributes: [.shadow: shadow])
        }

        /// Sets the shadow to be used in interpolation.
        /// - parameter color: the shadow color.
        /// - parameter blurRadius: the shadow blur radius.
        /// - parameter offset: the shadow offset.
        public static func shadow(_ color: OzColor, blurRadius: CGFloat, offset: CGSize = .zero) -> Attribute {
            let shadow = NSShadow()
            shadow.shadowColor = color
            shadow.shadowBlurRadius = blurRadius
            shadow.shadowOffset = offset

            return .shadow(shadow)
        }

        /// Sets the strikethrough settings to be applied to text in interpolation.
        /// - parameter value: strikethrough style.
        /// - parameter color: strikethrough color.
        public static func strikethrough(_ value: NSUnderlineStyle, color: OzColor) -> Attribute {
            return .init(attributes: [
                .strikethroughStyle: value.rawValue,
                .strikethroughColor: color,
            ])
        }

        /// Sets the strikethrough color to be applied to text in interpolation.
        /// - parameter color: strikethrough color.
        public static func strikethroughColor(_ color: OzColor) -> Attribute {
            return .init(attributes: [.strikethroughColor: color])
        }

        /// Sets the strikethrough style to be applied to text in interpolation.
        /// - parameter value: strikethrough style.
        public static func strikethroughStyle(_ value: NSUnderlineStyle) -> Attribute {
            return .init(attributes: [.strikethroughStyle: value.rawValue])
        }

        /// Sets the stroke settings to be applied to text in interpolation.
        /// - parameter color: stroke color.
        /// - parameter width: stroke width.
        public static func stroke(_ color: OzColor, width: Double) -> Attribute {
            return .init(attributes: [
                .strokeColor: color,
                .strokeWidth: width,
            ])
        }

        /// Sets the stroke color to be applied to text in interpolation.
        /// - parameter color: stroke color.
        public static func strokeColor(_ color: OzColor) -> Attribute {
            return .init(attributes: [.strokeColor: color])
        }

        /// Sets the stroke width to be applied to text in interpolation.
        /// - parameter value: stroke width.
        public static func strokeWidth(_ value: Double) -> Attribute {
            return .init(attributes: [.strokeWidth: value])
        }

        /// Specifies a text effect.
        /// - parameter value: text effect.
        public static func textEffect(_ value: String) -> Attribute {
            return .init(attributes: [.textEffect: value])
        }

        /// Sets the underline settings to be applied to text in interpolation.
        /// - parameter value: underline style.
        /// - parameter color: underline color.
        public static func underline(_ value: NSUnderlineStyle, color: OzColor) -> Attribute {
            return .init(attributes: [
                .underlineStyle: value.rawValue,
                .underlineColor: color,
            ])
        }

        /// Sets the underline color to be applied to text in interpolation.
        /// - parameter color: underline color.
        public static func underlineColor(_ color: OzColor) -> Attribute {
            return .init(attributes: [.underlineColor: color])
        }

        /// Sets the underline style to be applied to text in interpolation.
        /// - parameter value: underline style.
        public static func underlineStyle(_ value: NSUnderlineStyle) -> Attribute {
            return .init(attributes: [.underlineStyle: value.rawValue])
        }

#if os(macOS)
        public static func verticalGlyphForm(_ value: VerticalGlyphForm) -> Attribute {
            return .init(attributes: [.verticalGlyphForm: value.rawValue])
        }
#else
        @available(*, unavailable, message: "In iOS, horizontal text is always used and specifying a different value is undefined.")
        public static func verticalGlyphForm(_ value: VerticalGlyphForm) -> Attribute {
            return .init(attributes: [:])
        }
#endif

        /// Sets writingDirection overrides.
        /// - parameter settings: specifies nested levels of writing direction overrides, in order from outermost to innermost.
        public static func writingDirection(_ settings: WritingDirection...) -> Attribute {
            return .writingDirection(settings)
        }

        /// Sets writingDirection overrides.
        /// - parameter settings: specifies nested levels of writing direction overrides, in order from outermost to innermost.
        public static func writingDirection(_ settings: [WritingDirection]) -> Attribute {
            let settingValues = settings.map { $0.rawValue }
            return .init(attributes: [.writingDirection: settingValues])
        }
    }
}

#if os(macOS)
// MARK: - MacOS
extension AttributedString.Attribute {
    public static func cursor(_ cursor: NSCursor) -> AttributedString.Attribute {
        return .init(attributes: [.cursor: cursor])
    }

    public static func glyphInfo(_ info: NSGlyphInfo) -> AttributedString.Attribute {
        return .init(attributes: [.glyphInfo: info])
    }

    public static func markedClauseSegment(_ value: Int) -> AttributedString.Attribute {
        return .init(attributes: [.markedClauseSegment: value])
    }

    public static func superscript(_ value: Double) -> AttributedString.Attribute {
        return .init(attributes: [.superscript: value])
    }

    public static func textAlternatives(_ value: NSTextAlternatives) -> AttributedString.Attribute {
        return .init(attributes: [.textAlternatives: value])
    }

    public static func toolTip(_ value: String) -> AttributedString.Attribute {
        return .init(attributes: [.toolTip: value])
    }
}
#endif

// MARK: - paragraph style
extension AttributedString.Attribute {
    public static func paragraphStyle(_ style: NSParagraphStyle) -> AttributedString.Attribute {
        return .init(attributes: [.paragraphStyle: style])
    }

    public static func alignment(_ value: NSTextAlignment) -> AttributedString.Attribute {
        return .paragraphStyle(NSParagraphStyle.create { style in
            style.alignment = value
        })
    }

    public static func firstLineHeadIndent(_ value: CGFloat) -> AttributedString.Attribute {
        return .paragraphStyle(NSParagraphStyle.create { style in
            style.firstLineHeadIndent = value
        })
    }

    public static func headIndent(_ value: CGFloat) -> AttributedString.Attribute {
        return .paragraphStyle(NSParagraphStyle.create { style in
            style.headIndent = value
        })
    }

    public static func tailIndent(_ value: CGFloat) -> AttributedString.Attribute {
        return .paragraphStyle(NSParagraphStyle.create { style in
            style.tailIndent = value
        })
    }

    public static func lineHeightMultiple(_ value: CGFloat) -> AttributedString.Attribute {
        return .paragraphStyle(NSParagraphStyle.create { style in
            style.lineHeightMultiple = value
        })
    }

    public static func minimumLineHeight(_ value: CGFloat) -> AttributedString.Attribute {
        return .paragraphStyle(NSParagraphStyle.create { style in
            style.minimumLineHeight = value
        })
    }

    public static func maximumLineHeight(_ value: CGFloat) -> AttributedString.Attribute {
        return .paragraphStyle(NSParagraphStyle.create { style in
            style.maximumLineHeight = value
        })
    }

    public static func lineHeight(_ value: CGFloat) -> AttributedString.Attribute {
        return .paragraphStyle(NSParagraphStyle.create { style in
            style.minimumLineHeight = value
            style.maximumLineHeight = value
        })
    }

    public static func lineSpacing(_ value: CGFloat) -> AttributedString.Attribute {
        return .paragraphStyle(NSParagraphStyle.create { style in
            style.lineSpacing = value
        })
    }

    public static func paragraphSpacing(_ value: CGFloat) -> AttributedString.Attribute {
        return .paragraphStyle(NSParagraphStyle.create { style in
            style.paragraphSpacing = value
        })
    }

    public static func paragraphSpacingBefore(_ value: CGFloat) -> AttributedString.Attribute {
        return .paragraphStyle(NSParagraphStyle.create { style in
            style.paragraphSpacingBefore = value
        })
    }

    public static func tabStops(_ tabs: NSTextTab...) -> AttributedString.Attribute {
        return .tabStops(tabs)
    }

    public static func tabStops(_ tabs: [NSTextTab]) -> AttributedString.Attribute {
        return .paragraphStyle(NSParagraphStyle.create { style in
            style.tabStops = tabs
        })
    }

    public static func defaultTabInterval(_ value: CGFloat) -> AttributedString.Attribute {
        return .paragraphStyle(NSParagraphStyle.create { style in
            style.defaultTabInterval = value
        })
    }

    public static func lineBreakMode(_ value: NSLineBreakMode) -> AttributedString.Attribute {
        return .paragraphStyle(NSParagraphStyle.create { style in
            style.lineBreakMode = value
        })
    }

    public static func hyphenationFactor(_ value: Float) -> AttributedString.Attribute {
        return .paragraphStyle(NSParagraphStyle.create { style in
            style.hyphenationFactor = value
        })
    }

    public static func allowsDefaultTighteningForTruncation(_ value: Bool) -> AttributedString.Attribute {
        return .paragraphStyle(NSParagraphStyle.create { style in
            style.allowsDefaultTighteningForTruncation = value
        })
    }

    public static func baseWritingDirection(_ value: NSWritingDirection) -> AttributedString.Attribute {
        return .paragraphStyle(NSParagraphStyle.create { style in
            style.baseWritingDirection = value
        })
    }
}

#if os(macOS)
// MARK: - mac os paragraph style
extension AttributedString.Attribute {
    public static func textBlocks(_ blocks: NSTextBlock...) -> AttributedString.Attribute {
        return .textBlocks(blocks)
    }

    public static func textBlocks(_ blocks: [NSTextBlock]) -> AttributedString.Attribute {
        return .paragraphStyle(NSParagraphStyle.create { style in
            style.textBlocks = blocks
        })
    }

    public static func textLists(_ lists: NSTextList...) -> AttributedString.Attribute {
        return .textLists(lists)
    }

    public static func textLists(_ lists: [NSTextList]) -> AttributedString.Attribute {
        return .paragraphStyle(NSParagraphStyle.create { style in
            style.textLists = lists
        })
    }

    public static func tighteningFactorForTruncation(_ value: Float) -> AttributedString.Attribute {
        return .paragraphStyle(NSParagraphStyle.create { style in
            style.tighteningFactorForTruncation = value
        })
    }

    public static func headerLevel(_ value: Int) -> AttributedString.Attribute {
        return .paragraphStyle(NSParagraphStyle.create { style in
            style.headerLevel = value
        })
    }
}
#endif

// MARK: - private
extension AttributedString.StringInterpolation {
    private func mergeAttributes(_ attributes: [AttributedString.Attribute]) -> [NSAttributedString.Key: Any] {
        return attributes
            .map { $0.attributes }
            .reduce([:]) { (attributes, newAttributes) in
                return attributes.merging(newAttributes, uniquingKeysWith: { $1 })
            }
    }
}

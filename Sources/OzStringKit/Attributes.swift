//
//  Attributes.swift
//  OzStringKit
//
//  Created by Konstantin Oznobikhin on Mar 21, 2020.
//  Copyright © 2020 Konstantin Oznobikhin. All rights reserved.
//

import Foundation

#if os(macOS)
    import AppKit
#else
    import UIKit
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

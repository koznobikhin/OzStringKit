//
//  ParagraphStyleAttributes.swift
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

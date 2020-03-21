//
//  MacOSAttributes.swift
//  OzStringKit
//
//  Created by Konstantin Oznobikhin on Mar 21, 2020.
//  Copyright © 2020 Konstantin Oznobikhin. All rights reserved.
//

import Foundation

#if os(macOS)
    import AppKit
#endif

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

//
//  MacOSParagraphStyleAttributes.swift
//  OzStringKit
//
//  Created by Konstantin Oznobikhin on Mar 21, 2020.
//  Copyright © 2020 Konstantin Oznobikhin. All rights reserved.
//

import Foundation

#if os(macOS)

import AppKit

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

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
#else
    import UIKit
#endif

extension NSParagraphStyle {
    public static func create(_ setup: (NSMutableParagraphStyle) -> Void) -> NSParagraphStyle {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.setParagraphStyle(NSParagraphStyle.default)
        setup(paragraphStyle)

        return paragraphStyle
    }
}

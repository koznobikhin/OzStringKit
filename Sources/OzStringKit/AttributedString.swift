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

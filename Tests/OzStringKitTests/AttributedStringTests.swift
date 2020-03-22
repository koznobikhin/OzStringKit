//
//  AttributedStringTests.swift
//  OzStringKit
//
//  Created by Konstantin Oznobikhin on Mar 23, 2020.
//  Copyright © 2020 Konstantin Oznobikhin. All rights reserved.
//

import XCTest
@testable import OzStringKit

final class AttributedStringTests: XCTestCase {
    func testMutipleAttributes() {
        let testSample = NSAttributedString(
            string: "\(0)",
            attributes: [
                .foregroundColor: OzColor.red,
                .link: "https://swift.org",
                .kern: 4.0,
        ])

        let sut = attributedString("\(0, .color(.red), .link("https://swift.org"), .kern(4.0))")

        XCTAssertEqual(sut, testSample)
    }
}

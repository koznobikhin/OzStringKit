//
//  AttributesTests.swift
//  OzStringKit
//
//  Created by Konstantin Oznobikhin on Mar 23, 2020.
//  Copyright © 2020 Konstantin Oznobikhin. All rights reserved.
//

import XCTest
@testable import OzStringKit

final class AttributesTests: XCTestCase {
    func testBackgroundColor() {
        let sample = NSAttributedString(string: "test", attributes: [.backgroundColor: OzColor.red])

        let sut = attributedString("\("test", .backgroundColor(.red))")

        XCTAssertEqual(sut, sample)
    }

    func testFont() {
        let sample = NSAttributedString(string: "test", attributes: [.font: OzFont.systemFont(ofSize: 10.0)])

        let sut = attributedString("\("test", .font(.systemFont(ofSize: 10.0)))")

        XCTAssertEqual(sut, sample)
    }

    func testColor() {
        let sample = NSAttributedString(string: "test", attributes: [.foregroundColor: OzColor.red])

        let sut = attributedString("\("test", .color(.red))")

        XCTAssertEqual(sut, sample)
    }

    func testKern() {
        let sample = NSAttributedString(string: "test", attributes: [.kern: 2.0])

        let sut = attributedString("\("test", .kern(2.0))")

        XCTAssertEqual(sut, sample)
    }

    func testLinkUrl() {
        let url = URL(string: "https://swift.org/")!
        let sample = NSAttributedString(string: "test", attributes: [.link: url])

        let sut = attributedString("\("test", .link(url))")

        XCTAssertEqual(sut, sample)
    }

    func testLinkString() {
        let sample = NSAttributedString(string: "test", attributes: [.link: "https://swift.org/"])

        let sut = attributedString("\("test", .link("https://swift.org/"))")

        XCTAssertEqual(sut, sample)
    }

    func testObliqueness() {
        let sample = NSAttributedString(string: "test", attributes: [.obliqueness: 1.0])

        let sut = attributedString("\("test", .obliqueness(1.0))")

        XCTAssertEqual(sut, sample)
    }

    func testShadowObject() {
        let sampleShadow = NSShadow()
        sampleShadow.shadowColor = OzColor.black
        sampleShadow.shadowBlurRadius = 3.0
        sampleShadow.shadowOffset = CGSize(width: 1.0, height: 2.0)

        let sample = NSAttributedString(string: "test", attributes: [.shadow: sampleShadow])

        let sutShadow = NSShadow()
        sutShadow.shadowColor = OzColor.black
        sutShadow.shadowBlurRadius = 3.0
        sutShadow.shadowOffset = CGSize(width: 1.0, height: 2.0)

        let sut = attributedString("\("test", .shadow(sutShadow))")

        XCTAssertEqual(sut, sample)
    }

    func testShadow() {
        let sampleShadow = NSShadow()
        sampleShadow.shadowColor = OzColor.black
        sampleShadow.shadowBlurRadius = 3.0
        sampleShadow.shadowOffset = CGSize(width: 1.0, height: 2.0)

        let sample = NSAttributedString(string: "test", attributes: [.shadow: sampleShadow])

        let sut = attributedString(
            "\("test", .shadow(.black, blurRadius: 3.0, offset: CGSize(width: 1.0, height: 2.0)))")

        XCTAssertEqual(sut, sample)
    }

    func testStrikethrough() {
        let sample = NSAttributedString(
            string: "test",
            attributes: [
                .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                .strikethroughColor: OzColor.red,
        ])

        let sut = attributedString("\("test", .strikethrough(.single, color: .red))")

        XCTAssertEqual(sut, sample)
    }

    func testStrikethroughStyle() {
        let sample = NSAttributedString(
            string: "test",
            attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue])

        let sut = attributedString("\("test", .strikethroughStyle(.single))")

        XCTAssertEqual(sut, sample)
    }

    func testStrikethroughColor() {
        let sample = NSAttributedString(
            string: "test",
            attributes: [.strikethroughColor: OzColor.red])

        let sut = attributedString("\("test", .strikethroughColor(.red))")

        XCTAssertEqual(sut, sample)
    }

    func testStroke() {
        let sample = NSAttributedString(
            string: "test",
            attributes: [
                .strokeWidth: 2.0,
                .strokeColor: OzColor.red,
        ])

        let sut = attributedString("\("test", .stroke(.red, width: 2.0))")

        XCTAssertEqual(sut, sample)
    }

    func testStrokeWidth() {
        let sample = NSAttributedString(
            string: "test",
            attributes: [.strokeWidth: 1])

        let sut = attributedString("\("test", .strokeWidth(1))")

        XCTAssertEqual(sut, sample)
    }

    func testStrokeColor() {
        let sample = NSAttributedString(
            string: "test",
            attributes: [.strokeColor: OzColor.red])

        let sut = attributedString("\("test", .strokeColor(.red))")

        XCTAssertEqual(sut, sample)
    }

    func testUnderline() {
        let sample = NSAttributedString(
            string: "test",
            attributes: [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .underlineColor: OzColor.red,
        ])

        let sut = attributedString("\("test", .underline(.single, color: .red))")

        XCTAssertEqual(sut, sample)
    }

    func testUnderlineStyle() {
        let sample = NSAttributedString(
            string: "test",
            attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])

        let sut = attributedString("\("test", .underlineStyle(.single))")

        XCTAssertEqual(sut, sample)
    }

    func testUnderlineColor() {
        let sample = NSAttributedString(
            string: "test",
            attributes: [.underlineColor: OzColor.red])

        let sut = attributedString("\("test", .underlineColor(.red))")

        XCTAssertEqual(sut, sample)
    }
}

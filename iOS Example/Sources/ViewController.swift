//
//  ViewController.swift
//  iOS Example
//
//  Created by Konstantin Oznobikhin on Mar 20, 2020.
//  Copyright © 2020 Konstantin Oznobikhin. All rights reserved.
//

import UIKit

import OzStringKit

class ViewController: UIViewController {
    @IBOutlet private weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.label.attributedText = self.buildText()
    }

    private func buildText() -> NSAttributedString {
        let attributedText = NSMutableAttributedString()

        let colorfulText = attributedString("""
            \("Some colorful text:", .underline(.single, color: .red))
            \("red", .color(.red)), \("orange", .color(.orange)), \("yellow", .color(.yellow)), \
            \("green", .color(.green)), \("blue", .color(.blue))
            """)

        attributedText.append(colorfulText)
        attributedText.append(attributedString("\n\n"))

        let swiftLogo = UIImage(named: "SwiftLogo")!
        let url = URL(string: "https://swift.org/")!
        attributedText.append(attributedString("\(image: swiftLogo) an image and an \("url", .link(url))"))

        let _: AttributedString.Attribute

        let shadow = NSShadow()
        shadow.shadowColor = UIColor.black.withAlphaComponent(0.3)
        shadow.shadowBlurRadius = 4.0
        shadow.shadowOffset = CGSize(width: 0.0, height: 2.0)
        return attributedString("\(attributedText, .alignment(.center), .shadow(shadow))")
    }
}

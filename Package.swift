// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OzStringKit",
    products: [
        .library(
            name: "OzStringKit",
            targets: ["OzStringKit"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "OzStringKit",
            dependencies: []),
        .testTarget(
            name: "OzStringKitTests",
            dependencies: ["OzStringKit"]),
    ]
)

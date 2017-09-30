// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "parsel",
    products: [
        .library(
            name: "parsel",
            targets: ["parsel"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "example",
            dependencies: []),
        .target(
            name: "parsel",
            dependencies: []),
        .testTarget(
            name: "parselTests",
            dependencies: ["parsel"])
    ]
)

// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Parsel",
    products: [
        .library(
            name: "Parsel",
            targets: ["Parsel"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Example",
            dependencies: ["Parsel"]),
        .target(
            name: "Parsel",
            dependencies: []),
        .testTarget(
            name: "ParselTests",
            dependencies: ["Parsel"])
    ]
)

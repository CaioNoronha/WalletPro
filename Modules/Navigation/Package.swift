// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Navigation",
    platforms: [
        .iOS(.v26)
    ],
    products: [
        .library(
            name: "Navigation",
            targets: ["Navigation"]
        ),
    ],
    dependencies: [
        .package(path: "../Home"),
        .package(path: "../Search"),
        .package(path: "../DesignSystem")
    ],
    targets: [
        .target(
            name: "Navigation",
            dependencies: [
                .product(name: "Home", package: "Home"),
                .product(name: "Search", package: "Search"),
                .product(name: "DesignSystem", package: "DesignSystem")
            ]
        ),
        .testTarget(
            name: "NavigationTests",
            dependencies: ["Navigation"]
        ),
    ]
)

// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Search",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        .library(
            name: "Search",
            targets: ["Search"]
        ),
    ],
    dependencies: [
        .package(path: "../Home")
    ],
    targets: [
        .target(
            name: "Search",
            dependencies: [
                .product(name: "Home", package: "Home")
            ]
        ),
        .testTarget(
            name: "SearchTests",
            dependencies: ["Search"]
        ),
    ]
)

// swift-tools-version: 6.2

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
        .package(path: "../Home"),
        .package(path: "../Network"),
        .package(path: "../Utils")
    ],
    targets: [
        .target(
            name: "Search",
            dependencies: [
                .product(name: "Home", package: "Home"),
                .product(name: "Network", package: "Network"),
                .product(name: "Utils", package: "Utils")
            ]
        ),
        .testTarget(
            name: "SearchTests",
            dependencies: ["Search"]
        ),
    ]
)

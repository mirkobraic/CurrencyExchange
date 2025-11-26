// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PresentationLayer",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "PresentationLayer",
            targets: ["PresentationLayer"]
        ),
    ],
    dependencies: [
        .package(name: "DomainLayer", path: "../DomainLayer"),
    ],
    targets: [
        .target(
            name: "PresentationLayer",
            dependencies: [
                .product(name: "DomainLayer", package: "DomainLayer"),
            ]
        ),
        .testTarget(
            name: "PresentationLayerTests",
            dependencies: ["PresentationLayer"]
        ),
    ]
)

// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Domain",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "CurrencySelectorDomain",
            targets: ["CurrencySelectorDomain"]
        ),
        .library(
            name: "ExchangeCalculatorDomain",
            targets: ["ExchangeCalculatorDomain"]
        ),
    ],
    dependencies: [
        .package(name: "Shared", path: "../Shared"),
    ],
    targets: [
        .target(
            name: "CurrencySelectorDomain",
            dependencies: [
                .product(name: "Shared", package: "Shared"),
            ]
        ),
        .target(
            name: "ExchangeCalculatorDomain",
            dependencies: [
                .product(name: "Shared", package: "Shared"),
            ]
        ),

        .testTarget(
            name: "CurrencySelectorDomainTests",
            dependencies: ["CurrencySelectorDomain"]
        ),
        .testTarget(
            name: "ExchangeCalculatorDomainTests",
            dependencies: ["ExchangeCalculatorDomain"]
        ),
    ]
)

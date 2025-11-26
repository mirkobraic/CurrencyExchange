// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Presentation",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "CurrencySelector",
            targets: ["CurrencySelector"]
        ),
        .library(
            name: "ExchangeCalculator",
            targets: ["ExchangeCalculator"]
        ),
    ],
    dependencies: [
        .package(name: "Domain", path: "../Domain"),
        .package(name: "Shared", path: "../Shared"),
    ],
    targets: [
        .target(
            name: "CurrencySelector",
            dependencies: [
                .product(name: "CurrencySelectorDomain", package: "Domain"),
                .product(name: "Shared", package: "Shared"),
            ]
        ),
        .target(
            name: "ExchangeCalculator",
            dependencies: [
                .product(name: "ExchangeCalculatorDomain", package: "Domain"),
                .product(name: "Shared", package: "Shared"),
            ]
        ),

        .testTarget(
            name: "CurrencySelectorTests",
            dependencies: ["CurrencySelector"]
        ),
        .testTarget(
            name: "ExchangeCalculatorTests",
            dependencies: ["ExchangeCalculator"]
        ),
    ]
)

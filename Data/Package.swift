// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Data",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "CurrencyDataSource",
            targets: ["CurrencyDataSource"]
        ),
        .library(
            name: "ExchangeRateDataSource",
            targets: ["ExchangeRateDataSource"]
        ),
    ],
    dependencies: [
        .package(name: "Domain", path: "../Domain"),
        .package(name: "Shared", path: "../Shared"),
    ],
    targets: [
        .target(
            name: "CurrencyDataSource",
            dependencies: [
                .product(name: "CurrencySelectorDomain", package: "Domain"),
                .product(name: "Shared", package: "Shared"),
            ]
        ),
        .target(
            name: "ExchangeRateDataSource",
            dependencies: [
                .product(name: "ExchangeCalculatorDomain", package: "Domain"),
                .product(name: "Shared", package: "Shared"),
            ]
        ),
    ]
)

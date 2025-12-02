# CurrencyExchange

A small SwiftUI iOS app for quick USDc ↔︎ fiat conversions, built with a clean, modular architecture.

## Demo

https://github.com/user-attachments/assets/4bcbea31-c95f-48a3-bd14-220d7f52bcb8

## Requirements
- iOS 18.0+
- Xcode 26
- Swift 6.2

## Architecture
- PresentationLayer: SwiftUI views/view models (Observation)
- DomainLayer: Use cases and contracts
- DataLayer: API client, endpoints
- Tech: Swift Concurrency (actors, async/await), DI via FactoryKit, SPM modules



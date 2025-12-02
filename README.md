# CurrencyExchange

A small SwiftUI iOS app for quick USDc ↔︎ fiat conversions, built with a clean, modular architecture.

## Demo


## Requirements
- iOS 18
- Xcode 16+

## Architecture
- PresentationLayer: SwiftUI views/view models (Observation), reusable UI components, assets
- DomainLayer: Use cases and contracts (pure business logic)
- DataLayer: Async/await API client, endpoints, models (API host: `api.dolarapp.dev`)
- Tech: Swift Concurrency (actors, async/await), DI via FactoryKit, SPM modules



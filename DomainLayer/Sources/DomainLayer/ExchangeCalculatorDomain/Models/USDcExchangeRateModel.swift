import Foundation

public struct USDcExchangeRateModel: Sendable {

    public let ask: Decimal
    public let bid: Decimal
    public let book: String
    public let date: Date?

    public init(ask: Decimal, bid: Decimal, book: String, date: Date?) {
        self.ask = ask
        self.bid = bid
        self.book = book
        self.date = date
    }

    public func calculateUSDcPrice(from tickerAmount: Decimal, action: ExchangeAction) -> Decimal {
        switch action {
        case .buying:
            guard ask != 0 else { return 0 }

            return tickerAmount / ask
        case .selling:
            guard bid != 0 else { return 0 }

            return tickerAmount / bid
        }
    }

    public func calculateTickerPrice(from usdcAmount: Decimal, action: ExchangeAction) -> Decimal {
        switch action {
        case .buying:
            usdcAmount * bid
        case .selling:
            usdcAmount * ask
        }
    }

}

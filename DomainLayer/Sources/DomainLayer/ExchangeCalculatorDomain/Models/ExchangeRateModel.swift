import Foundation

public struct ExchangeRateModel: Sendable {

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

}

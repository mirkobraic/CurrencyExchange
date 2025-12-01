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

    func buyUSDc(amount: Decimal) -> Decimal {
        // implement transformation logic based on ask and bid values
        0
    }

    func sellUSDc(amount: Decimal) -> Decimal {
        0
    }

    func buy(amount: Decimal) -> Decimal {

    }

    func sell(amount: Decimal) -> Decimal {
        
    }

}

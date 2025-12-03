import Foundation

struct ExchangePolicy: Sendable {

    private let getExchangeCoeficient: @Sendable (Decimal, Decimal, ExchangeDirection) -> Decimal

    func getExchangeCoeficient(ask: Decimal, bid: Decimal, direction: ExchangeDirection) -> Decimal {
        getExchangeCoeficient(ask, bid, direction)
    }

}

extension ExchangePolicy {

    static let standard = ExchangePolicy { ask, bid, direction in
        switch direction {
        case .buyBase:
            return ask
        case .sellBase:
            return bid
        }
    }

}

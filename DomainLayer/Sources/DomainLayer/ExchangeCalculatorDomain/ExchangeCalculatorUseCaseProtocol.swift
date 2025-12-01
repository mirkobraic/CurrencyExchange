import Foundation

public protocol ExchangeCalculatorUseCaseProtocol: Actor {

    func getUSDcExchangeRate(for ticker: String, action: ExchangeAction) async throws -> Decimal

}

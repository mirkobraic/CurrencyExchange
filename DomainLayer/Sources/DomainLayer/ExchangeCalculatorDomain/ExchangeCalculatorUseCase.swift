import Foundation

public actor ExchangeCalculatorUseCase: ExchangeCalculatorUseCaseProtocol {

    private let dataSource: ExchangeRateDataSource

    public init(dataSource: ExchangeRateDataSource) {
        self.dataSource = dataSource
    }

    public func getUSDcExchangeRate(for ticker: String, action: ExchangeAction) async throws -> Decimal {
        let exchangeRates = try await dataSource.getUSDcExchangeRates(for: [ticker])

        guard let requestedExchangeRate = exchangeRates.first else {
            throw ExchangeRateError.rateNotFound
        }

        return switch action {
        case .buying:
            requestedExchangeRate.bid
        case .selling:
            requestedExchangeRate.ask
        }
    }

}

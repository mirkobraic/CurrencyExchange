public actor ExchangeCalculatorUseCase: ExchangeCalculatorUseCaseProtocol {

    private let dataSource: ExchangeRateDataSource

    public init(dataSource: ExchangeRateDataSource) {
        self.dataSource = dataSource
    }

    public func getUSDcExchangeRates(for tickers: [String]) async throws -> [USDcExchangeRateModel] {
        try await dataSource.getUSDcExchangeRates(for: tickers)
    }

    public func getUSDcExchangeRate(for ticker: String) async throws -> USDcExchangeRateModel {
        let exchangeRates = try await dataSource.getUSDcExchangeRates(for: [ticker])

        guard let requestedExchangeRate = exchangeRates.first else {
            throw ExchangeRateError.rateNotFound
        }

        return requestedExchangeRate
    }

}

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

    public func getUSDcExchangeRateStream(for ticker: String) async throws -> AsyncStream<USDcExchangeRateModel> {
        // todo: AsyncStream (or Combine) should be used to ensure we don't have stale exchange rates.
        fatalError("Unimplemented")
    }

}

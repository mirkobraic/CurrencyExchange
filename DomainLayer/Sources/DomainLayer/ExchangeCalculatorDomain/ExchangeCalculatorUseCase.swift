public actor ExchangeCalculatorUseCase: ExchangeCalculatorUseCaseProtocol {

    private let dataSource: ExchangeRateDataSource

    public init(dataSource: ExchangeRateDataSource) {
        self.dataSource = dataSource
    }

    public func getExchangeRates(for tickers: [String]) async throws -> [ExchangeRateModel] {
        try await dataSource.getExchangeRates(for: tickers)
    }

}

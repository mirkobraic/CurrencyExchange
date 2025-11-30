public protocol ExchangeRateDataSource: Actor {

    func getExchangeRates(for tickers: [String]) async throws -> [ExchangeRateModel]

}

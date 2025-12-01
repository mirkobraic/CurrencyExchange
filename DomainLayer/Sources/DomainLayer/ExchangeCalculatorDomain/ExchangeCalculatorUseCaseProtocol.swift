public protocol ExchangeCalculatorUseCaseProtocol: Actor {

    func getUSDcExchangeRates(for tickers: [String]) async throws -> [USDcExchangeRateModel]

    func getUSDcExchangeRate(for ticker: String) async throws -> USDcExchangeRateModel

}

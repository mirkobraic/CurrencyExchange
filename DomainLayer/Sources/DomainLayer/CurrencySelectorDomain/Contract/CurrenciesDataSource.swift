public protocol CurrenciesDataSource: Actor {

    func getAvailableCurrencies() async throws -> [String]

}

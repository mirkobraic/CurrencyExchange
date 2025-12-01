public actor CurrencySelectorUseCase: CurrencySelectorUseCaseProtocol {

    private let dataSource: CurrencyListDataSource

    public init(dataSource: CurrencyListDataSource) {
        self.dataSource = dataSource
    }

    public func getAvailableCurrencies() async throws -> [String] {
        do {
            return try await dataSource.getAvailableCurrencies()
        } catch {
            return [
                "MXN",
                "ARS",
                "BRL",
                "COP",
                "EURc",
              ]
        }
    }

}

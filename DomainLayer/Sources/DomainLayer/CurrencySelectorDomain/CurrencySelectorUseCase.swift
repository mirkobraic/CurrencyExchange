public actor CurrencySelectorUseCase: CurrencySelectorUseCaseProtocol {

    private let dataSource: CurrenciesDataSource

    public init(dataSource: CurrenciesDataSource) {
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

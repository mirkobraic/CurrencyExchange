public actor CurrencySelectorUseCase: CurrencySelectorUseCaseProtocol {

    private let dataSource: CurrenciesDataSource

    public init(dataSource: CurrenciesDataSource) {
        self.dataSource = dataSource
    }

    public func getAvailableCurrencies() async throws -> [String] {
        try await dataSource.getAvailableCurrencies()
    }

}

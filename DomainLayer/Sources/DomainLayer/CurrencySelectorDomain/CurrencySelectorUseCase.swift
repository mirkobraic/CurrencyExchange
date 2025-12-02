public actor CurrencySelectorUseCase: CurrencySelectorUseCaseProtocol {

    private let dataSource: CurrencyListDataSource

    private var currencyListCache: [String]?

    // todo: placeholder currencies should be loaded from local storage.
    private let placholderCurrencies = [
        "MXN",
        "ARS",
        "BRL",
        "COP",
        "EURc",
    ]

    public init(dataSource: CurrencyListDataSource) {
        self.dataSource = dataSource
    }

    public func getAvailableCurrencies() async throws -> [String] {
        // todo: implement cache invalidation mechanism
        if let currencyListCache { return currencyListCache }

        do {
            let currencies = try await dataSource.getAvailableCurrencies()
            currencyListCache = currencies

            return currencies
        } catch {
            currencyListCache = placholderCurrencies

            return placholderCurrencies
        }
    }

}

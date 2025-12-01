import FactoryKit
import DataLayer
import DomainLayer
import PresentationLayer

// MARK: - Data layer
extension Container {

    private var apiClient: Factory<APIClientProtocol> {
        self { APIClient() }
    }

    private var currencyListClient: Factory<CurrencyListDataSource> {
        self { CurrencyListClient(apiClient: self.apiClient()) }
    }

    private var exchangeRateClient: Factory<ExchangeRateClient> {
        self { ExchangeRateClient(apiClient: self.apiClient()) }
    }

}

// MARK: - Domain layer
extension Container: @retroactive AutoRegistering {

    public func autoRegister() {
        currencySelectorUseCase.register { CurrencySelectorUseCase(dataSource: self.currencyListClient()) }
        exchangeCalculatorUseCase.register { ExchangeCalculatorUseCase(dataSource: self.exchangeRateClient()) }
    }

}

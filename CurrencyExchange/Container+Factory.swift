import FactoryKit
import DataLayer
import DomainLayer
import PresentationLayer

// MARK: - Data layer
extension Container {

    private var apiClient: Factory<APIClientProtocol> {
        self { APIClient() }
    }

    private var currenciesClient: Factory<CurrenciesDataSource> {
        self { CurrenciesClient(apiClient: self.apiClient()) }
    }

    private var exchangeRateClient: Factory<ExchangeRateClient> {
        self { ExchangeRateClient(apiClient: self.apiClient()) }
    }

}

// MARK: - Domain layer
extension Container: @retroactive AutoRegistering {

    public func autoRegister() {
        currencySelectorUseCase.register { CurrencySelectorUseCase(dataSource: self.currenciesClient()) }
        exchangeCalculatorUseCase.register { ExchangeCalculatorUseCase(dataSource: self.exchangeRateClient()) }
    }

}

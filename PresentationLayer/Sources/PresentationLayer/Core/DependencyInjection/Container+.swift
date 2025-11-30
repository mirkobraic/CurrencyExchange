import FactoryKit
import DomainLayer

public extension Container {

    var currencySelectorUseCase: Factory<CurrencySelectorUseCaseProtocol> {
        self { fatalError("currencySelectorUseCase not registered") }
    }

    var exchangeCalculatorUseCase: Factory<ExchangeCalculatorUseCaseProtocol> {
        self { fatalError("exchangeCalculatorUseCase not registered") }
    }

}

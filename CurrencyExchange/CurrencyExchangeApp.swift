import SwiftUI
import CurrencySelector
import CurrencySelectorDomain
import ExchangeCalculator
import ExchangeCalculatorDomain

@main
struct CurrencyExchangeApp: App {
    @State var exchangeCalculatorViewModel = ExchangeCalculatorViewModel(useCase: ExchangeCalculatorUseCase())

    var body: some Scene {
        WindowGroup {
            ExchangeCalculatorView(viewModel: exchangeCalculatorViewModel)
        }
    }
}

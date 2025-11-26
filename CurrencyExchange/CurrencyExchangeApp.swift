import SwiftUI
import DomainLayer
import PresentationLayer

@main
struct CurrencyExchangeApp: App {
    @State var exchangeCalculatorViewModel = ExchangeCalculatorViewModel(useCase: ExchangeCalculatorUseCase())

    var body: some Scene {
        WindowGroup {
            ExchangeCalculatorView(viewModel: exchangeCalculatorViewModel)
        }
    }
}

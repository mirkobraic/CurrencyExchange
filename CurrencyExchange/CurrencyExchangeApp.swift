import SwiftUI
import DataLayer
import DomainLayer
import PresentationLayer

@main
struct CurrencyExchangeApp: App {
    @State var exchangeCalculatorViewModel = ExchangeCalculatorViewModel(useCase: ExchangeCalculatorUseCase(dataSource: ExchangeRateClient(apiClient: APIClient())))

    var body: some Scene {
        WindowGroup {
            ExchangeCalculatorView(viewModel: exchangeCalculatorViewModel)
        }
    }
}

import SwiftUI
import PresentationLayer

@main
struct CurrencyExchangeApp: App {

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ExchangeCalculatorView()
            }
        }
    }

}

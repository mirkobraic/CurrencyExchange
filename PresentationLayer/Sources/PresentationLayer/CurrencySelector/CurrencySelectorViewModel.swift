import SwiftUI
import FactoryKit

@Observable @MainActor
public class CurrencySelectorViewModel {

    @ObservationIgnored @Injected(\.currencySelectorUseCase) private var useCase

    var viewState: Loadable<[TickerSelectionModel]> = .initial(placeholder: .placeholder)

    func fetchTickers() async {
        do {
            let tickers = try await useCase.getAvailableCurrencies()
                .map { TickerSelectionModel(value: $0, imageName: $0) }

            withAnimation {
                viewState = tickers.isEmpty ? .empty : .loaded(tickers)
            }
        } catch {
            withAnimation {
                viewState = .error
            }
        }
    }

}

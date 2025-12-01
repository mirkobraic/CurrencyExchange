import Observation
import FactoryKit

@Observable @MainActor
public class CurrencySelectorViewModel {

    @ObservationIgnored @Injected(\.currencySelectorUseCase) private var useCase

    var tickers: [String] = []

    func fetchTickers() async {
        do {
            tickers = try await useCase.getAvailableCurrencies()
        } catch {
            print(error)
        }
    }

}

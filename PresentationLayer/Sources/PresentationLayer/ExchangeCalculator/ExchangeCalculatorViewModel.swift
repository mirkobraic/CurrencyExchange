import Observation
import FactoryKit

@Observable @MainActor
public class ExchangeCalculatorViewModel {

    @ObservationIgnored @Injected(\.exchangeCalculatorUseCase) private var useCase

    var primaryInputModel = AmountTextFieldModel(ticker: "USDc", amount: nil, supportsSelection: false)
    var secondaryInputModel = AmountTextFieldModel(ticker: "MXN", amount: nil, supportsSelection: true)

    func switchCurrenciesButtonTap() {
        let temp = primaryInputModel
        primaryInputModel = secondaryInputModel
        secondaryInputModel = temp
    }

    func tickerButtonTap() {
        
    }

    func fetchExchangeRates() async {
        do {
            let response = try await useCase.getExchangeRates(for: ["MXN"])
            print(response)
        } catch {
            print(error)
        }
    }

}

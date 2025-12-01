import Observation
import FactoryKit
import DomainLayer

@Observable @MainActor
public class ExchangeCalculatorViewModel {

    @ObservationIgnored @Injected(\.exchangeCalculatorUseCase) private var useCase

    var activeField: ExchangeField?
    var primaryInputField: ExchangeTextFieldModel
    var secondaryInputField: ExchangeTextFieldModel

    private var exchangeRate: ExchangeRate?

    var subtitleText: String? {
        guard let exchangeRate else { return nil }

        return String("1 USDc = \(exchangeRate.rate) \(exchangeRate.ticker)")
    }

    init() {
        activeField = nil
        primaryInputField = ExchangeTextFieldModel(ticker: "USDc", amount: nil, supportsSelection: false)
        secondaryInputField = ExchangeTextFieldModel(ticker: "MXN", amount: nil, supportsSelection: true)
    }

    func fetchExchangeRate(for ticker: String) async {
        do {
            let model = try await useCase.getUSDcExchangeRate(for: ticker)
        } catch {
            print(error)
        }
    }

}

extension ExchangeCalculatorViewModel {

    func switchCurrenciesButtonTap() {
        let temp = primaryInputField
        primaryInputField = secondaryInputField
        secondaryInputField = temp
    }

    func tickerButtonTap(_ field: ExchangeField) {
        activeField = field
    }

    func getTicker(for field: ExchangeField) -> String {
        switch field {
        case .primary:
            primaryInputField.ticker
        case .secondary:
            secondaryInputField.ticker
        }
    }

    func setTicker(for field: ExchangeField, newValue: String) {
        guard newValue != getTicker(for: field) else { return }

        switch field {
        case .primary:
            primaryInputField.ticker = newValue
        case .secondary:
            secondaryInputField.ticker = newValue
        }

        activeField = nil
        Task {
            await fetchExchangeRate(for: newValue)
        }
    }

}

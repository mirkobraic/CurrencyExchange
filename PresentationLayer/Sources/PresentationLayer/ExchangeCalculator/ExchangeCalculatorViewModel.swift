import Observation
import FactoryKit


@Observable @MainActor
public class ExchangeCalculatorViewModel {

    @ObservationIgnored @Injected(\.exchangeCalculatorUseCase) private var useCase

    var activeField: ActiveField?
    var primaryInputModel: AmountTextFieldModel
    var secondaryInputModel: AmountTextFieldModel

    private var exchangeRate: ExchangeRate?

    var subtitleText: String? {
        guard let exchangeRate else { return nil }

        return String("1 USDc = \(exchangeRate.rate) \(exchangeRate.ticker)")
    }

    init() {
        activeField = nil
        primaryInputModel = AmountTextFieldModel(ticker: "USDc", amount: nil, supportsSelection: false)
        secondaryInputModel = AmountTextFieldModel(ticker: "MXN", amount: nil, supportsSelection: true)
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

extension ExchangeCalculatorViewModel {

    func switchCurrenciesButtonTap() {
        let temp = primaryInputModel
        primaryInputModel = secondaryInputModel
        secondaryInputModel = temp
    }

    func tickerButtonTap(_ field: ActiveField) {
        activeField = field
    }

    func getTicker(for field: ActiveField) -> String {
        switch field {
        case .primary:
            primaryInputModel.ticker
        case .secondary:
            secondaryInputModel.ticker
        }
    }

    func setTicker(for field: ActiveField, newValue: String) {
        guard newValue != getTicker(for: field) else { return }

        switch field {
        case .primary:
            primaryInputModel.ticker = newValue
        case .secondary:
            secondaryInputModel.ticker = newValue
        }

        activeField = nil
    }

}

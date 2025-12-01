import Foundation
import Observation
import FactoryKit
import DomainLayer

@Observable @MainActor
public class ExchangeCalculatorViewModel {

    @ObservationIgnored @Injected(\.exchangeCalculatorUseCase) private var useCase

    var primaryInputField = ExchangeTextFieldModel.USDc
    var secondaryInputField = ExchangeTextFieldModel(ticker: "MXN", amount: 0, supportsSelection: true)

    var currencySelectionActiveField: ExchangeField?
    var subtitleText: String?

    private var exchangeRate: USDcExchangeRateModel?

    private func fetchExchangeRate(for ticker: String) async {
        do {
            let model = try await useCase.getUSDcExchangeRate(for: ticker)
            updateViewModel(with: model)
        } catch {
            print(error)
        }
    }

    private func updateViewModel(with exchangeRate: USDcExchangeRateModel) {
        self.exchangeRate = exchangeRate

        // Primary field value should remain unchanged.
        let primaryAmount = primaryInputField.amount
        if secondaryInputField.isUSDc {
            secondaryInputField.amount = exchangeRate.calculateUSDcPrice(from: primaryAmount, action: .buying)
        } else {
            secondaryInputField.amount = exchangeRate.calculateTickerPrice(from: primaryAmount, action: .buying)
        }

        subtitleText = subtitleText(for: exchangeRate)
    }

    private func subtitleText(for exchangeRate: USDcExchangeRateModel) -> String {
        var ticker = ""
        var rate = Decimal(0)

        if secondaryInputField.isUSDc {
            ticker = primaryInputField.ticker
            rate = exchangeRate.calculateTickerPrice(from: 1, action: action(for: .primary))
        } else {
            ticker = secondaryInputField.ticker
            rate = exchangeRate.calculateTickerPrice(from: 1, action: action(for: .secondary))
        }

        return String("1 USDc = \(rate) \(ticker)")
    }

    private func action(for field: ExchangeField) -> ExchangeAction {
        switch field {
        case .primary:
            return .selling
        case .secondary:
            return .buying
        }
    }

}

extension ExchangeCalculatorViewModel {

    func viewAppearedTask() async {
        await fetchExchangeRate(for: secondaryInputField.ticker)
    }

    func switchCurrenciesButtonTap() {
        let temp = primaryInputField
        primaryInputField = secondaryInputField
        secondaryInputField = temp

        if let exchangeRate {
            updateViewModel(with: exchangeRate)
        }
    }

    func tickerButtonTap(_ field: ExchangeField) {
        currencySelectionActiveField = field
    }

    func amountUpdated(for field: ExchangeField, amount: Decimal) {
        guard let exchangeRate else { return }

        switch field {
        case .primary:
            if secondaryInputField.isUSDc {
                secondaryInputField.amount = exchangeRate.calculateUSDcPrice(from: amount, action: action(for: .secondary))
            } else {
                secondaryInputField.amount = exchangeRate.calculateTickerPrice(from: amount, action: action(for: .secondary))
            }
        case .secondary:
            if primaryInputField.isUSDc {
                primaryInputField.amount = exchangeRate.calculateUSDcPrice(from: amount, action: action(for: .primary))
            } else {
                primaryInputField.amount = exchangeRate.calculateTickerPrice(from: amount, action: action(for: .primary))
            }
        }
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

        currencySelectionActiveField = nil
        Task {
            await fetchExchangeRate(for: newValue)
        }
    }

}

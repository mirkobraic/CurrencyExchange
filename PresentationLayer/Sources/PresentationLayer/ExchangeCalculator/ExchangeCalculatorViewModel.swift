import Foundation
import Observation
import FactoryKit
import DomainLayer

@Observable @MainActor
public class ExchangeCalculatorViewModel {

    @ObservationIgnored @Injected(\.exchangeCalculatorUseCase) private var useCase

    var primaryInput = ExchangeInputModel(field: .USDc, exchangeAction: .selling)
    // todo: Ticker value should be loaded from storage (user defaults, for example)
    var secondaryInput = ExchangeInputModel(
        field: .init(ticker: "MXN", imageName: "MXN", amount: 0, supportsSelection: true),
        exchangeAction: .buying
    )

    var currencySelectionActiveInput: ExchangeInput?
    var subtitleText: Loadable<String> = .initial(placeholder: "Placeholder string")

    private var exchangeRate: USDcExchangeRateModel?

    private func fetchExchangeRate(for ticker: String) async {
        guard !ticker.isEmpty else {
            subtitleText = .empty
            return
        }

        do {
            let model = try await useCase.getUSDcExchangeRate(for: ticker)
            updateViewModel(with: model)
        } catch {
            subtitleText = .error
        }
    }

    private func updateViewModel(with exchangeRate: USDcExchangeRateModel) {
        self.exchangeRate = exchangeRate

        // Keep USDc value unchanged.
        if primaryInput.field.isUSDc {
            update(input: &secondaryInput, with: primaryInput.field.amount, exchangeRate: exchangeRate)
        } else if secondaryInput.field.isUSDc {
            update(input: &primaryInput, with: secondaryInput.field.amount, exchangeRate: exchangeRate)
        }

        subtitleText = .loaded(subtitleText(for: exchangeRate))
    }

    private func subtitleText(for exchangeRate: USDcExchangeRateModel) -> String {
        let usdcAmount = Decimal(1)
        let nonUSDcInput = secondaryInput.field.isUSDc ? primaryInput : secondaryInput
        let ticker = nonUSDcInput.field.ticker
        let rate = exchangeRate.calculateTickerPrice(from: usdcAmount, action: nonUSDcInput.exchangeAction)

        return String("\(usdcAmount.asCurrency(currencySymbol: "USDc")) = \(rate.asCurrency(currencySymbol: ticker))")
    }

    private func update(
        input: inout ExchangeInputModel,
        with amount: Decimal,
        exchangeRate: USDcExchangeRateModel
    ) {
        if input.field.isUSDc {
            input.field.amount = exchangeRate.calculateUSDcPrice(from: amount, action: input.exchangeAction)
        } else {
            input.field.amount = exchangeRate.calculateTickerPrice(from: amount, action: input.exchangeAction)
        }
    }

}

extension ExchangeCalculatorViewModel {

    func viewAppearedTask() async {
        await fetchExchangeRate(for: secondaryInput.field.ticker)
    }

    func switchCurrenciesButtonTap() {
        swap(&primaryInput.field, &secondaryInput.field)

        if let exchangeRate {
            updateViewModel(with: exchangeRate)
        }
    }

    func tickerButtonTap(_ field: ExchangeInput) {
        currencySelectionActiveInput = field
    }

    func amountUpdated(for field: ExchangeInput, amount: Decimal) {
        guard let exchangeRate else { return }

        switch field {
        case .primary:
            update(input: &secondaryInput, with: amount, exchangeRate: exchangeRate)
        case .secondary:
            update(input: &primaryInput, with: amount, exchangeRate: exchangeRate)
        }
    }

    func getTicker(for field: ExchangeInput) -> String {
        switch field {
        case .primary:
            primaryInput.field.ticker
        case .secondary:
            secondaryInput.field.ticker
        }
    }

    func setTicker(for field: ExchangeInput, newValue: String) {
        guard newValue != getTicker(for: field) else { return }

        switch field {
        case .primary:
            primaryInput.field.ticker = newValue
            primaryInput.field.imageName = newValue
        case .secondary:
            secondaryInput.field.ticker = newValue
            secondaryInput.field.imageName = newValue
        }

        currencySelectionActiveInput = nil
        Task {
            await fetchExchangeRate(for: newValue)
        }
    }

}

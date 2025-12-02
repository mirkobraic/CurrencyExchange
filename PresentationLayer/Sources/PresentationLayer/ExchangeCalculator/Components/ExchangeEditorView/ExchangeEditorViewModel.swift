import Foundation
import Observation
import DomainLayer

@Observable
class ExchangeEditorViewModel {

    var primaryInput: ExchangeEditorInputModel
    var secondaryInput: ExchangeEditorInputModel

    private var exchangeRate: USDcExchangeRateModel?

    init(
        primaryField: ExchangeTextFieldModel,
        secondaryField: ExchangeTextFieldModel,
        exchangeRate: USDcExchangeRateModel? = nil
    ) {
        primaryInput = .init(field: primaryField, exchangeAction: .selling)
        secondaryInput = .init(field: secondaryField, exchangeAction: .buying)
        self.exchangeRate = exchangeRate
    }

    func update(exchangeRate: USDcExchangeRateModel) {
        self.exchangeRate = exchangeRate

        // TODO: Non-ideal solution.
        // Keep USDc value unchanged.
        if primaryInput.field.isUSDc {
            update(input: &secondaryInput, with: primaryInput.field.amount, exchangeRate: exchangeRate)
        } else if secondaryInput.field.isUSDc {
            update(input: &primaryInput, with: secondaryInput.field.amount, exchangeRate: exchangeRate)
        }
    }

    func getTicker(for field: ExchangeEditorInputType) -> String {
        switch field {
        case .primary:
            primaryInput.field.ticker
        case .secondary:
            secondaryInput.field.ticker
        }
    }
    
    func update(ticker: String, for field: ExchangeEditorInputType) {
        switch field {
        case .primary:
            primaryInput.field.ticker = ticker
            primaryInput.field.imageName = ticker
        case .secondary:
            secondaryInput.field.ticker = ticker
            secondaryInput.field.imageName = ticker
        }
    }

    func userInput(_ amount: Decimal, in field: ExchangeEditorInputType) {
        guard let exchangeRate else { return }

        switch field {
        case .primary:
            update(input: &secondaryInput, with: amount, exchangeRate: exchangeRate)
        case .secondary:
            update(input: &primaryInput, with: amount, exchangeRate: exchangeRate)
        }
    }

    func switchCurrenciesButtonTap() {
        swap(&primaryInput.field, &secondaryInput.field)

        if let exchangeRate {
            update(exchangeRate: exchangeRate)
        }
    }

    private func update(
        input: inout ExchangeEditorInputModel,
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

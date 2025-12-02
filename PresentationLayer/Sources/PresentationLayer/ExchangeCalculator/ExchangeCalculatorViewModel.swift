import Foundation
import Observation
import FactoryKit
import DomainLayer

@Observable @MainActor
public class ExchangeCalculatorViewModel {

    @ObservationIgnored @Injected(\.exchangeCalculatorUseCase) private var useCase

    var exchangeEditorViewModel = ExchangeEditorViewModel(
        primaryField: .USDc,
        secondaryField: .init(ticker: "MXN", imageName: "MXN", amount: 0, supportsSelection: true) // TODO: Default ticker value should be loaded from storage (user defaults, for example)
    )

    var currencySelectionActiveInput: ExchangeEditorInputType?
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
        exchangeEditorViewModel.update(exchangeRate: exchangeRate)
        updateSubtitleText(for: exchangeRate)
    }

    private func updateSubtitleText(for exchangeRate: USDcExchangeRateModel) {
        let usdcAmount = Decimal(1)
        // TODO: Non-ideal solution.
        let nonUSDcInput = exchangeEditorViewModel.secondaryInput.field.isUSDc ?
        exchangeEditorViewModel.primaryInput :
        exchangeEditorViewModel.secondaryInput

        let ticker = nonUSDcInput.field.ticker
        let rate = exchangeRate.calculateTickerPrice(from: usdcAmount, action: nonUSDcInput.exchangeAction)

        let subtitle = String(
            format: "%@ = %@",
            usdcAmount.asCurrency(currencySymbol: Constants.usdcTicker),
            rate.asCurrency(currencySymbol: ticker)
        )

        subtitleText = .loaded(subtitle)
    }

}

extension ExchangeCalculatorViewModel {

    func viewAppearedTask() async {
        await fetchExchangeRate(for: exchangeEditorViewModel.getTicker(for: .secondary))
    }

    func tickerButtonTap(_ field: ExchangeEditorInputType) {
        currencySelectionActiveInput = field
    }

    func currenciesSwitched() {
        guard let exchangeRate else { return }

        updateSubtitleText(for: exchangeRate)
    }

    func getTicker(for field: ExchangeEditorInputType) -> String {
        exchangeEditorViewModel.getTicker(for: field)
    }

    func currencySelected(for field: ExchangeEditorInputType, newValue: String) {
        exchangeEditorViewModel.update(ticker: newValue, for: field)

        currencySelectionActiveInput = nil
        Task {
            await fetchExchangeRate(for: newValue)
        }
    }

}

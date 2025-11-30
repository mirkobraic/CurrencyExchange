import Observation
import FactoryKit

@Observable @MainActor
public class ExchangeCalculatorViewModel {

    @ObservationIgnored @Injected(\.exchangeCalculatorUseCase) private var useCase

    func fetchExchangeRates() async {
        do {
            let response = try await useCase.getExchangeRates(for: ["MXN"])
            print(response)
        } catch {
            print(error)
        }
    }

}

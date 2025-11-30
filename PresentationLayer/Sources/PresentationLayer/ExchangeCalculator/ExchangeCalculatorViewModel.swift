import Observation
import DomainLayer

@Observable @MainActor
public class ExchangeCalculatorViewModel {

    private let useCase: ExchangeCalculatorUseCaseProtocol

    public init(useCase: ExchangeCalculatorUseCaseProtocol) {
        self.useCase = useCase
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

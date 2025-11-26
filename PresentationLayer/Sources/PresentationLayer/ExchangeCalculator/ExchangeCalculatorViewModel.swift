import Observation
import DomainLayer

@Observable
public class ExchangeCalculatorViewModel {

    private let useCase: ExchangeCalculatorUseCaseProtocol

    public init(useCase: ExchangeCalculatorUseCaseProtocol) {
        self.useCase = useCase
    }

}

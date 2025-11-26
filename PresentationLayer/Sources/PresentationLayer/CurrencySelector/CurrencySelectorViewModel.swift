import Observation
import DomainLayer

@Observable
public class CurrencySelectorViewModel {

    private let useCase: CurrencySelectorUseCaseProtocol

    public init(useCase: CurrencySelectorUseCaseProtocol) {
        self.useCase = useCase
    }

}


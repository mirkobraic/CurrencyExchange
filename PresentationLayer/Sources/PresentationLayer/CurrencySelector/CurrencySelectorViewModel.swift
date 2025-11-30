import Observation
import FactoryKit

@Observable @MainActor
public class CurrencySelectorViewModel {

    @ObservationIgnored @Injected(\.currencySelectorUseCase) private var useCase

}

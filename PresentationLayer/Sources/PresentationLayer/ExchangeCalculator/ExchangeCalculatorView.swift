import SwiftUI

public struct ExchangeCalculatorView: View {

    @State var viewModel = ExchangeCalculatorViewModel()

    public init() {}

    public var body: some View {
        Text("ExchangeCalculatorView")
            .task {
                await viewModel.fetchExchangeRates()
            }
    }

}

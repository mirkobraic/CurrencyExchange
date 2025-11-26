import SwiftUI

public struct ExchangeCalculatorView: View {

    var viewModel: ExchangeCalculatorViewModel

    public init(viewModel: ExchangeCalculatorViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        Text("ExchangeCalculatorView")
    }

}

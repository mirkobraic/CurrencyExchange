import SwiftUI

public struct CurrencySelectorView: View {

    var viewModel: CurrencySelectorViewModel

    public init(viewModel: CurrencySelectorViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        Text("CurrencySelectorView")
    }

}

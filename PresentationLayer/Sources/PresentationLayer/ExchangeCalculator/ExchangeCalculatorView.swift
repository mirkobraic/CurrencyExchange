import SwiftUI

public struct ExchangeCalculatorView: View {

    @State var viewModel = ExchangeCalculatorViewModel()

    public init() {}

    public var body: some View {
        VStack(alignment: .leading, spacing: .gutter(withMultiplier: 3)) {
            Spacer(minLength: 50)

            titleView

            exchangeView
                .maxHeight(alignment: .top)
        }
        .padding(.horizontal, .doubleGutter)
        .padding(.top, .gutter(withMultiplier: 3))
        .maxSize()
        .background(.background.secondary)
        .task {
            await viewModel.fetchExchangeRates()
        }
    }

}

private extension ExchangeCalculatorView {

    var titleView: some View {
        VStack(alignment: .leading) {
            Text("Exchange calculator", bundle: #bundle)
                .font(.largeTitle.bold())

            Text("Subtitle")
                .font(.title3.bold())
                .foregroundStyle(Color.accentColor)
        }
    }

    var exchangeView: some View {
        VStack(spacing: .doubleGutter) {
            AmountTextField(model: $viewModel.primaryInputModel) {
                viewModel.tickerButtonTap()
            }

            AmountTextField(model: $viewModel.secondaryInputModel) {
                viewModel.tickerButtonTap()
            }
        }
        .overlay {
            switchCurrenciesButton
        }
    }

    var switchCurrenciesButton: some View {
        Button {
            viewModel.switchCurrenciesButtonTap()
        } label: {
            Image(.arrowDown)
                .resizable()
                .frame(width: 32, height: 32)
        }
        .background {
            Circle()
                .fill(.background.secondary)
                .frame(width: 32, height: 32)
        }
    }

}

#Preview {

    NavigationStack {
        ExchangeCalculatorView()
    }

}

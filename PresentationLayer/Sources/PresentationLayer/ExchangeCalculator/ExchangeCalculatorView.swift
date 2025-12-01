import SwiftUI

public struct ExchangeCalculatorView: View {

    @State var viewModel = ExchangeCalculatorViewModel()
    @State var presentingSheet = false
    @State var selectedTicker = "MXN"

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
        .background(Color(.backgroundPrimary))
        .sheet(isPresented: $presentingSheet) {
            CurrencySelectorView(selectedTicker: $selectedTicker)
        }
    }

}

private extension ExchangeCalculatorView {

    var titleView: some View {
        VStack(alignment: .leading) {
            Text("Exchange calculator", bundle: #bundle)
                .font(.header3)
                .foregroundStyle(Color(.contentPrimary))

            Text("Subtitle")
                .font(.body)
                .foregroundStyle(Color.accentColor)
        }
    }

    var exchangeView: some View {
        VStack(spacing: .doubleGutter) {
            AmountTextField(model: $viewModel.primaryInputModel) {
                viewModel.tickerButtonTap()
                presentingSheet = true
            }

            AmountTextField(model: $viewModel.secondaryInputModel) {
                viewModel.tickerButtonTap()
                presentingSheet = true
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
                .fill(Color(.backgroundPrimary))
                .frame(width: 32, height: 32)
        }
    }

}

#Preview {

    NavigationStack {
        ExchangeCalculatorView()
    }

}

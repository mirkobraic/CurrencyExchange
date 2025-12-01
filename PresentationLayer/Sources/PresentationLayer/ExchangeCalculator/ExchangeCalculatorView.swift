import SwiftUI

public struct ExchangeCalculatorView: View {

    @State var viewModel = ExchangeCalculatorViewModel()
    @FocusState private var focusedField: ExchangeField?

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
        .onTapGesture { focusedField = nil }
        .sheet(item: $viewModel.activeField) { activeField in
            CurrencySelectorView(selectedTicker: Binding {
                viewModel.getTicker(for: activeField)
            } set: { newValue in
                viewModel.setTicker(for: activeField, newValue: newValue)
            })
        }
    }

}

private extension ExchangeCalculatorView {

    var titleView: some View {
        VStack(alignment: .leading) {
            Text("Exchange calculator", bundle: #bundle)
                .font(.header3)
                .foregroundStyle(Color(.contentPrimary))

            Text(viewModel.subtitleText ?? "")
                .font(.body)
                .foregroundStyle(Color.accentColor)
        }
    }

    var exchangeView: some View {
        VStack(spacing: .doubleGutter) {
            ExchangeTextField(model: $viewModel.primaryInputField) {
                viewModel.tickerButtonTap(.primary)
            }
            .focused($focusedField, equals: .primary)

            ExchangeTextField(model: $viewModel.secondaryInputField) {
                viewModel.tickerButtonTap(.secondary)
            }
            .focused($focusedField, equals: .secondary)
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

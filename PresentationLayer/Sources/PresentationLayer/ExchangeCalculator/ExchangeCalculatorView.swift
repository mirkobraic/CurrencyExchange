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
        .sheet(item: $viewModel.currencySelectionActiveField) { activeField in
            CurrencySelectorView(selectedTicker: Binding {
                viewModel.getTicker(for: activeField)
            } set: { newValue in
                viewModel.setTicker(for: activeField, newValue: newValue)
            })
        }
        .task { await viewModel.viewAppearedTask() }
    }

}

private extension ExchangeCalculatorView {

    var titleView: some View {
        VStack(alignment: .leading, spacing: .defaultGutter) {
            Text("Exchange calculator", bundle: #bundle)
                .font(.header3)
                .foregroundStyle(Color(.contentPrimary))

            Text(viewModel.subtitleText ?? " ")
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
            .onChange(of: viewModel.primaryInputField.amount) { oldValue, newValue in
                guard
                    oldValue != newValue,
                    focusedField == .primary
                else { return }

                viewModel.amountUpdated(for: .primary, amount: newValue)
            }

            ExchangeTextField(model: $viewModel.secondaryInputField) {
                viewModel.tickerButtonTap(.secondary)
            }
            .focused($focusedField, equals: .secondary)
            .onChange(of: viewModel.secondaryInputField.amount) { oldValue, newValue in
                guard
                    oldValue != newValue,
                    focusedField == .secondary
                else { return }

                viewModel.amountUpdated(for: .secondary, amount: newValue)
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

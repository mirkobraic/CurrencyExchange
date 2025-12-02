import SwiftUI

public struct ExchangeCalculatorView: View {

    @State var viewModel = ExchangeCalculatorViewModel()
    @FocusState private var focusedField: ExchangeInput?

    public init() {}

    public var body: some View {
        VStack(alignment: .leading, spacing: .gutter(withMultiplier: 3)) {
            Spacer(minLength: 50)

            headerView

            exchangeView
                .maxHeight(alignment: .top)
        }
        .padding(.horizontal, .doubleGutter)
        .padding(.top, .gutter(withMultiplier: 3))
        .maxSize()
        .background(Color(.backgroundPrimary))
        .onTapGesture { focusedField = nil }
        .sheet(item: $viewModel.currencySelectionActiveInput) { activeField in
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

    var headerView: some View {
        VStack(alignment: .leading, spacing: .defaultGutter) {
            Text("Exchange calculator", bundle: #bundle)
                .font(.header3)
                .foregroundStyle(Color(.contentPrimary))

            subtitleView
        }
    }

    var subtitleView: some View {
        LoadableShimmerView(viewModel.subtitleText) { text in
            Text(text)
                .font(.body)
                .foregroundStyle(Color.accentColor)
        } emptyView: {
            Text(" ")
                .font(.body)
        } errorView: {
            Text("Unable to load exchange rates.", bundle: #bundle)
                .font(.body)
                .foregroundStyle(Color.red)
        }
    }

    var exchangeView: some View {
        VStack(spacing: .doubleGutter) {
            ExchangeTextField(model: $viewModel.primaryInput.field) {
                viewModel.tickerButtonTap(.primary)
            }
            .focused($focusedField, equals: .primary)
            .onChange(of: viewModel.primaryInput.field.amount) { oldValue, newValue in
                guard
                    oldValue != newValue,
                    focusedField == .primary
                else { return }

                viewModel.amountUpdated(for: .primary, amount: newValue)
            }

            ExchangeTextField(model: $viewModel.secondaryInput.field) {
                viewModel.tickerButtonTap(.secondary)
            }
            .focused($focusedField, equals: .secondary)
            .onChange(of: viewModel.secondaryInput.field.amount) { oldValue, newValue in
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
            switchFocusedField()
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

    func switchFocusedField() {
        switch focusedField {
        case .primary:
            focusedField = .secondary
        case .secondary:
            focusedField = .primary
        case .none:
            break
        }
    }

}

#Preview {

    NavigationStack {
        ExchangeCalculatorView()
    }

}

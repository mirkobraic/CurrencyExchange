import SwiftUI

struct AmountTextField: View {

    @Binding var model: AmountTextFieldModel
    let onTickerTap: (() -> Void)?

    var body: some View {
        HStack(spacing: .defaultGutter) {
            tickerButton

            inputField
        }
        .padding(.horizontal, .doubleGutter)
        .padding(.vertical, .gutter(withMultiplier: 3))
        .background(
            RoundedRectangle(cornerRadius: .doubleGutter)
                .fill(.white)
        )
    }

}

private extension AmountTextField {

    var tickerButton: some View {
        Button {
            onTickerTap?()
        } label: {
            HStack(spacing: .defaultGutter) {
                Image(model.ticker, bundle: #bundle)
                    .resizable()
                    .frame(width: 16, height: 16)
                    .clipShape(.circle)

                Text(model.ticker)
                    .fontWeight(.medium)

                if model.supportsSelection {
                    Image(.chevronDown)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 12, height: 12)
                }
            }
        }
        .foregroundStyle(.primary)
        .disabled(!model.supportsSelection)
    }

    var inputField: some View {
        TextField("", value: $model.amount, format: .currency(code: "USD"))
            .keyboardType(.decimalPad)
            .multilineTextAlignment(.trailing)
            .fontWeight(.semibold)
            .maxWidth(alignment: .trailing)
    }

}

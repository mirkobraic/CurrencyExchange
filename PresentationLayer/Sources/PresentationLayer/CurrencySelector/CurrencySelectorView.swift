import SwiftUI

public struct CurrencySelectorView: View {

    @State var viewModel = CurrencySelectorViewModel()
    @Binding var selectedTicker: String
    @Environment(\.dismiss) var dismiss

    public var body: some View {
        VStack(spacing: .doubleGutter) {
            Capsule()
                .fill(Color(.contentSecondary))
                .frame(width: 36, height: 5)

            HStack {
                Text("Choose currency")
                    .font(.header4)
                    .foregroundStyle(Color(.contentPrimary))
                    .maxWidth(alignment: .leading)

                Button {
                    dismiss()
                } label: {
                    Image(.xButton)
                        .resizable()
                        .frame(width: 32, height: 32)
                }
            }
            .padding(.top, .defaultGutter)

            tickerList
        }
        .padding(.top, .defaultGutter)
        .padding(.horizontal, .doubleGutter)
        .presentationDetents([.medium])
        .maxSize()
        .background(Color(.backgroundPrimary))
        .task {
            await viewModel.fetchTickers()
        }
    }

}

private extension CurrencySelectorView {

    var tickerList: some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(viewModel.tickers, id: \.self) { ticker in
                    Button {
                        selectedTicker = ticker
                    } label: {
                        tickerCell(ticker: ticker, isSelected: ticker == selectedTicker)
                    }
                }
            }
            .clipShape(.rect(cornerRadius: .doubleGutter))
        }
    }

    func tickerCell(ticker: String, isSelected: Bool) -> some View {
        HStack(spacing: .defaultGutter) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.backgroundPrimary))
                    .frame(width: 40, height: 40)

                Image(ticker, bundle: #bundle)
                    .resizable()
                    .frame(width: 28, height: 28)
                    .clipShape(.circle)
            }

            Text(ticker)
                .font(.body)
                .foregroundStyle(Color(.contentPrimary))
                .maxWidth(alignment: .leading)

            Image(isSelected ? .radioSelected : .radioDeselected)
                .resizable()
                .frame(width: 24, height: 24)
        }
        .padding(.vertical, .defaultGutter)
        .padding(.horizontal, .doubleGutter)
        .background(Color(.backgroundSecondary))
    }

}

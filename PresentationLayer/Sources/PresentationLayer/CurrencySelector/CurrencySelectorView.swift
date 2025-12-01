import SwiftUI

public struct CurrencySelectorView: View {

    @State var viewModel = CurrencySelectorViewModel()
    @Binding var selectedTicker: String

    public var body: some View {
        VStack(spacing: .doubleGutter) {
            sheetCapsule

            header
                .padding(.top, .defaultGutter)

            LoadableShimmerView(viewModel.viewState) { model in
                tickerList(model)
            } emptyView: {
                EmptyView()
            } errorView: {
                EmptyView()
            }
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

    var sheetCapsule: some View {
        Capsule()
            .fill(Color(.contentSecondary))
            .frame(width: 36, height: 5)
    }

    var header: some View {
        HStack(spacing: .defaultGutter) {
            Text("Choose currency")
                .font(.header4)
                .foregroundStyle(Color(.contentPrimary))
                .maxWidth(alignment: .leading)

            DismissButton()
        }
    }

    func tickerList(_ tickers: [TickerSelectionModel]) -> some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(tickers, id: \.value) { ticker in
                    Button {
                        selectedTicker = ticker.value
                    } label: {
                        TickerSelectionCell(ticker: ticker, isSelected: ticker.value == selectedTicker)
                    }
                }
            }
            .clipShape(.rect(cornerRadius: .doubleGutter))
        }
    }

}

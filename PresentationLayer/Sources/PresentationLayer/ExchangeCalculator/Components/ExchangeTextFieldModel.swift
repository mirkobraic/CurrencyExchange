import Foundation

struct ExchangeTextFieldModel {

    var ticker: String
    var imageName: String?
    var amount: Decimal
    var supportsSelection: Bool

}

extension ExchangeTextFieldModel {

    var isUSDc: Bool {
        ticker == "USDc"
    }

    static let USDc = ExchangeTextFieldModel(ticker: "USDc", imageName: "USDc", amount: 0, supportsSelection: false)

}

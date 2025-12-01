struct TickerSelectionModel: Hashable {

    let value: String
    let imageName: String

}

extension Array where Element == TickerSelectionModel {

    static var placeholder: [TickerSelectionModel] {
        [
            TickerSelectionModel(value: "MXN", imageName: "MXN"),
            TickerSelectionModel(value: "ARS", imageName: "ARS"),
            TickerSelectionModel(value: "BRL", imageName: "BRL"),
            TickerSelectionModel(value: "COP", imageName: "COP"),
            TickerSelectionModel(value: "EURc", imageName: "EURc"),
        ]
    }

}

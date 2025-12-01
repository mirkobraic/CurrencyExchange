import Foundation
import DomainLayer

struct ExchangeRateResponse: Decodable {

    let ask: String
    let bid: String
    let book: String
    let date: Date

}

extension ExchangeRateResponse {

    func toDomainModel() -> ExchangeRateModel? {
        guard
            let ask = Decimal(string: ask),
            let bid = Decimal(string: bid)
        else { return nil }

        return ExchangeRateModel(ask: ask, bid: bid, book: book, date: date)
    }

}

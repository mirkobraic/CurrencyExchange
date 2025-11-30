enum ExchangeRateEndpoint: Endpoint {

    case tickers(params: Encodable & Sendable)

    var method: HTTPMethod {
        switch self {
        case .tickers: .get
        }
    }

    var path: String {
        switch self {
        case .tickers: "/tickers-currencies"
        }
    }

    var version: APIVersion {
        switch self {
        case .tickers: .v1
        }
    }

    var parameters: (any Encodable)? {
        switch self {
        case let .tickers(params): params
        }
    }

    var body: (any Encodable)? {
        switch self {
        case .tickers: nil
        }
    }

}

enum Environment {

    static let current: Self = .dev

    case dev

    var baseApiPath: String {
        switch self {
        case .dev:
            "https://api.dolarapp.dev"
        }
    }

}

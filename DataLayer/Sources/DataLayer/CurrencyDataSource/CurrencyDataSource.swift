import DomainLayer

public actor CurrencyDataSource: CurrencyDataSourceProtocol {

    let APIClient: APIClientProtocol

    public init(APIClient: APIClientProtocol) {
        self.APIClient = APIClient
    }

}

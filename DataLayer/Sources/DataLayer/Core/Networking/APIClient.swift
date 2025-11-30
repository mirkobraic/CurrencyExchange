import Foundation

public actor APIClient: APIClientProtocol {

    private let session: URLSession
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder

    init(session: URLSession = .shared, decoder: JSONDecoder = .init(), encoder: JSONEncoder = .init()) {
        self.session = session
        self.decoder = decoder
        self.encoder = encoder
    }

    public func request<E: Endpoint>(_ endpoint: E) async throws {
        let request = try makeURLRequest(from: endpoint)
        try await execute(request: request)
    }
    
    public func request<E: Endpoint, T: Decodable & Sendable>(_ endpoint: E) async throws -> T {
        let request = try makeURLRequest(from: endpoint)
        let data = try await execute(request: request)

        return try decoder.decode(T.self, from: data)
    }

    private func makeURLRequest(from endpoint: Endpoint) throws -> URLRequest {
        var components = URLComponents()
        components.host = Environment.current.baseApiPath
        components.path = endpoint.path.appending("/\(endpoint.version.rawValue)")
        components.queryItems = endpoint.parameters?.queryItems(with: encoder)

        guard let url = components.url else { throw APIClientError.invalidURL }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body?.httpBody(with: encoder)

        return request
    }

    @discardableResult
    private func execute(request: URLRequest) async throws -> Data {
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIClientError.invalidResponse
        }

        let statusCode = httpResponse.statusCode
        switch statusCode {
        case 200...299:
            return data
        case 400...499:
            throw APIClientError.clientError(statusCode)
        case 500...599:
            throw APIClientError.serverError(statusCode)
        default:
            throw APIClientError.unexpectedStatusCode(statusCode)
        }
    }

}

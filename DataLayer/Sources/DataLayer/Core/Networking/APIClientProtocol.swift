public protocol APIClientProtocol {

    func request<E: Endpoint>(_ endpoint: E) async throws

    func request<E: Endpoint, T: Decodable>(_ endpoint: E)  async throws -> T

}

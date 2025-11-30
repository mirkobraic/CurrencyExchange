import Foundation

public protocol Endpoint: Sendable {

    var method: HTTPMethod { get }
    var path: String { get }
    var version: APIVersion { get }
    var parameters: (any Encodable)? { get }
    var body: (any Encodable)? { get }

}

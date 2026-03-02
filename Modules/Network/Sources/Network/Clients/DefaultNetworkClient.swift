import Foundation

public struct DefaultNetworkClient: NetworkClient {
    private let transport: any NetworkTransport
    private let decoder: JSONDecoder

    public init(
        transport: any NetworkTransport,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.transport = transport
        self.decoder = decoder
    }

    public func request<Response: Decodable>(
        _ request: NetworkRequest,
        as type: Response.Type
    ) async throws -> Response {
        do {
            let response = try await transport.send(request)

            guard (200...299).contains(response.statusCode) else {
                throw NetworkError.invalidStatusCode(response.statusCode)
            }

            do {
                return try decoder.decode(Response.self, from: response.data)
            } catch {
                throw NetworkError.decodingFailure(error.localizedDescription)
            }
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.transportFailure(error.localizedDescription)
        }
    }
}

import Foundation

public enum JSONParser {
    public static func parse<T: Decodable>(_ data: Data, from type: T.Type) throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailure(error.localizedDescription)
        }
    }
}

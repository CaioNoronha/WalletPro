import Foundation
import Testing
@testable import Network

private struct SamplePayload: Decodable, Equatable {
    let value: String
}

@Test func routeKeyWithoutQueryUsesMethodAndPath() {
    let request = NetworkRequest(path: "/search/suggestions", method: .get)

    #expect(request.routeKey == "GET /search/suggestions")
}

@Test func routeKeyWithQueryIncludesSortedQueryItems() {
    let request = NetworkRequest(
        path: "/search/suggestions",
        method: .get,
        query: ["page": "2", "query": "coffee"]
    )

    #expect(request.routeKey == "GET /search/suggestions?page=2&query=coffee")
}

@Test func networkManagerMockReturnsPayloadForRegisteredRoute() async throws {
    let request = NetworkRequest(path: "/home/dashboard", method: .get)
    let expectedData = Data("{\"value\":\"ok\"}".utf8)
    let manager = NetworkManagerMock(payloadByRoute: [request.routeKey: expectedData])

    let data = try await manager.executeRequest(request: request)

    #expect(data == expectedData)
}

@Test func networkManagerMockThrowsWhenRouteIsMissing() async {
    let request = NetworkRequest(path: "/unknown", method: .get)
    let manager = NetworkManagerMock(payloadByRoute: [:])

    await #expect(throws: NetworkError.self) {
        _ = try await manager.executeRequest(request: request)
    }
}

@Test func jsonParserDecodesValidPayload() throws {
    let data = Data("{\"value\":\"ok\"}".utf8)

    let decoded = try JSONParser.parse(data, from: SamplePayload.self)

    #expect(decoded == SamplePayload(value: "ok"))
}

@Test func jsonParserThrowsDecodingFailureForInvalidPayload() {
    let invalidData = Data("{\"wrong\":\"shape\"}".utf8)

    #expect(throws: NetworkError.self) {
        _ = try JSONParser.parse(invalidData, from: SamplePayload.self)
    }
}

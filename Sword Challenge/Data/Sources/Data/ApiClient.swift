
import Foundation

public protocol ApiClient {
    func get<T>(request: URLRequest) async throws -> T where T: Decodable
    func getArray<T>(request: URLRequest) async throws -> [T] where T: Decodable
    func download(request: URLRequest) async throws -> Data
}

public final class ApiClientImplementation: ApiClient {

    private let jsonDecoder: JSONDecoder

    public init(jsonDecoder: JSONDecoder) {
        self.jsonDecoder = jsonDecoder
    }

    public func get<T>(request: URLRequest) async throws -> T where T: Decodable {
        let (data, _) = try await URLSession.shared.data(for: request)

        let object = try jsonDecoder.decode(T.self, from: data)

        return object
    }

    public func getArray<T>(request: URLRequest) async throws -> [T] where T: Decodable {

        let (data, _) = try await URLSession.shared.data(for: request)

        let array = try jsonDecoder.decode([T].self, from: data)

        return array
    }

    public func download(request: URLRequest) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(for: request)

        return data
    }
}

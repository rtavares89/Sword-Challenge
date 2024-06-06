
import Foundation
@testable import Data

struct ApiClientError: Error { }

final class ApiClientStub: ApiClient {

    var getCalled = false
    var getArrayCalled = false
    var downloadCalled = false
    var returnObject: Decodable!
    var returnArrayObject: [Decodable]!
    var returnData = Data()
    var shouldThrow = false

    func get<T>(request: URLRequest) async throws -> T where T : Decodable {
        getCalled = true

        if shouldThrow {
            throw ApiClientError()
        }

        return returnObject as! T
    }
    
    func getArray<T>(request: URLRequest) async throws -> [T] where T : Decodable {
        getArrayCalled = true

        if shouldThrow {
            throw ApiClientError()
        }

        return returnArrayObject as! [T]
    }
    
    func download(request: URLRequest) async throws -> Data {
        downloadCalled = true

        if shouldThrow {
            throw ApiClientError()
        }

        return returnData
    }
}

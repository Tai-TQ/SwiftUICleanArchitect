//
//  APIService.swift
//  DemoApp
//
//  Created by truong.quoc.tai on 7/28/25.
//

import Foundation
import SwiftUICleanArchitect

final class API: APIService {
    nonisolated(unsafe) static let shared = API()
    
    private init() {
        super.init(session: URLSession(configuration: .default))
    }
    
    override func preprocess<T, Decoder>(_ input: APIInput<T, Decoder>) -> APIInput<T, Decoder> {
        var newInput = input
        var header = input.endpoint.headers ?? [:]
        header["Content-Type"] = "application/json; charset=utf-8"
        header["Accept"] = "application/json"
        
//        header["Authorization"] = "Basic \(getAuthorization)"
        
        if input.endpoint.requireAccessToken {
//            header["JWTAuthorization"] = "Bearer " + AuthManager.shared.token
        }
        newInput.endpoint.headers = header
        return super.preprocess(newInput)
    }

    override func mapResponseError<T, Decoder>(httpResponse: HTTPURLResponse,
                                               data: Data,
                                               input: APIInput<T, Decoder>) throws -> Error {
        // Mapping error from Data to ErrorModel here
        throw try super.mapResponseError(httpResponse: httpResponse, data: data, input: input)
    }

    override func handleResponseError<T, Decoder>(error: Error, input: APIInput<T, Decoder>) async throws -> T {
        // Handle error here
        return try await super.handleResponseError(error: error, input: input)
    }

}
extension API {
    private var getAuthorization: String {
        let username = API.ConfigAuth.user
        let password = API.ConfigAuth.pass
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8) ?? Data()
        let base64LoginString = loginData.base64EncodedString()
        return base64LoginString
    }
}

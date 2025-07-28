//
//  APIError.swift
//  DemoApp
//
//  Created by truong.quoc.tai on 7/28/25.
//

import Foundation
import SwiftUICleanArchitect

enum StatusCode {
    static let forceLogin = 401
    static let invalidRefreshToken = 400
    static let notFound = 404
    static let internalError = 500
    static let serverMaintenanceError = 503
    static let forceUpdate = 426
}

final class APIResponseError: IDError {
    let statusCode: Int?
    let code: String?
    let endPoint: String?

    init(statusCode: Int?, code: String?, endPoint: String?, message: String) {
        self.statusCode = statusCode
        self.code = code
        self.endPoint = endPoint
        super.init(message: message)
    }

    static let notFound = APIResponseError(statusCode: StatusCode.notFound,
                                           code: "\(StatusCode.notFound)",
                                           endPoint: nil,
                                           message: "Not Found")
}

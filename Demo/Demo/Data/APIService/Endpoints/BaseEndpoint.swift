//
//  BaseEndpoint.swift
//  DemoApp
//
//  Created by truong.quoc.tai on 7/28/25.
//

import Foundation
import SwiftUICleanArchitect

class BaseEndpoint: Endpoint {
    var urlString: String
    var method: HTTPMethod
    var requireAccessToken: Bool
    var headers: [String : Any]? = nil
    var queryItems: [String : Any]? = nil
    var body: [String : Any]? = nil
    
    init(urlString: String,
         method: HTTPMethod,
         requireAccessToken: Bool,
         headers: [String : Any]? = nil,
         queryItems: [String : Any]? = nil,
         body: [String : Any]? = nil) {
        self.urlString = urlString
        self.method = method
        self.requireAccessToken = requireAccessToken
        
        var httpHeaders = [String : Any]()
        headers?.forEach { (key, value) in
            httpHeaders[key] = value
        }
        
        self.headers = httpHeaders
        self.queryItems = queryItems
        self.body = body
    }
}

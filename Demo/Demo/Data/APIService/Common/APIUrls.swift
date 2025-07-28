//
//  APIUrls.swift
//  DemoApp
//
//  Created by truong.quoc.tai on 7/28/25.
//

import Foundation

extension API {
    enum ConfigAuth {
        static let user = ""
        static let pass = ""
    }
    
    enum Urls {
        private static let host = "https://restcountries.com/"
        private static let apiv3 = "v3.1/"
        static let allCountries = host + apiv3 + "all"
    }
}

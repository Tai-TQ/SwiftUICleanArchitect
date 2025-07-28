//
//  CountriesEndPoint.swift
//  DemoApp
//
//  Created by truong.quoc.tai on 7/28/25.
//

import Foundation

final class CountriesEndPoint: BaseEndpoint {
    init() {
        let query: [String: Any] = [
            "fields": "name,capital,currencies,flags,timezones"
        ]
        super.init(
            urlString: API.Urls.allCountries,
            method: .get,
            requireAccessToken: false,
            queryItems: query
        )
    }
}

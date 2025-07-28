//
//  CountriesGateway.swift
//  DemoApp
//
//  Created by truong.quoc.tai on 7/28/25.
//

import Foundation
import SwiftUICleanArchitect

protocol CountriesGatewayProtocol {
    func fetchAllCountries() async throws -> [CountryModel]
}

struct CountriesGateway: CountriesGatewayProtocol {
    func fetchAllCountries() async throws -> [CountryModel] {
        let input = APIInput(endpoint: CountriesEndPoint(), decodingType: [CountryModel].self)
        return try await API.shared.request(input)
    }
}

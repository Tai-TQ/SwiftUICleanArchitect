//
//  CountriesUsecase.swift
//  DemoApp
//
//  Created by truong.quoc.tai on 7/28/25.
//

import Foundation

protocol CountriesUsecase {
    var gateway: CountriesGatewayProtocol { get }
}

extension CountriesUsecase {
    func fetchCountries() async throws -> [CountryModel] {
        try await gateway.fetchAllCountries()
    }
}
        

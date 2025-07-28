//
//  HomeViewModel.swift
//  Demo
//
//  Created by truong.quoc.tai on 7/29/25.
//

import Foundation
import SwiftUICleanArchitect

final class HomeViewModel: ViewModel, CountriesUsecase, @unchecked Sendable {
    var gateway: CountriesGatewayProtocol
    @Published var data: [CountryModel] = []
    
    init(gateway: any CountriesGatewayProtocol) {
        self.gateway = gateway
    }
    
    func getCountries() async {
        guard viewState == .loaded else { return }
        startLoading()
        do {
            let country = try await fetchCountries()
            Task { @MainActor in
                data = country
            }
            endLoading()
        } catch {
            handleError(error)
        }
    }
    
    func reloadCountries() async {
        guard viewState == .loaded else { return }
        startReloading()
        do {
            let country = try await fetchCountries()
            Task { @MainActor in
                data = country
            }
            endReloading()
        } catch {
            handleError(error)
        }
    }
    
}

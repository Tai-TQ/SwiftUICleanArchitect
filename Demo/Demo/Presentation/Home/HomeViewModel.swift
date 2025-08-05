//
//  HomeViewModel.swift
//  Demo
//
//  Created by truong.quoc.tai on 7/29/25.
//

import Foundation
import SwiftUICleanArchitect
import Combine

final class HomeViewModel: ViewModel, CountriesUsecase, @unchecked Sendable {
    var gateway: CountriesGatewayProtocol
    private var rootData: [CountryModel] = []
    @Published var dataShowing: [CountryModel] = []
    @Published var firstLoadDataSuccess: Bool = false
    
    private var searchSubject = PassthroughSubject<String, Never>()
    private var cancellable: Set<AnyCancellable> = []
    
    init(gateway: any CountriesGatewayProtocol) {
        self.gateway = gateway
        super.init()
        
        searchSubject
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .sink { [weak self] searchText in
                guard let self else { return }
                guard viewState == .loaded else { return }
                guard searchText.isNotEmpty else {
                    Task { @MainActor [weak self] in
                        guard let self else { return }
                        dataShowing = rootData
                    }
                    return
                }
                
                Task.detached { [weak self] in
                    guard let self else { return }
                    let filteredData = rootData.filter { country in
                        country.commonName.localizedCaseInsensitiveContains(searchText) ||
                        country.officialName.localizedCaseInsensitiveContains(searchText) ||
                        country.capital.filter { $0.localizedCaseInsensitiveContains(searchText) }.isNotEmpty
                    }
                    Task { @MainActor [weak self] in
                        guard let self else { return }
                        dataShowing = filteredData
                    }
                }
            }
            .store(in: &cancellable)
    }
    
    deinit {
        cancellable.removeAll()
    }
    
    func getCountries() async {
        guard viewState == .loaded else { return }
        startLoading()
        do {
            let country = try await fetchCountries()
            Task { @MainActor in
                rootData = country
                dataShowing = country
                firstLoadDataSuccess = true
            }
            endLoading()
        } catch {
            handleError(error)
        }
    }
    
    func searchContries(_ searchText: String) {
        searchSubject.send(searchText)
    }
    
    func reloadCountries() async {
        guard viewState == .loaded else { return }
        startReloading()
        do {
            let country = try await fetchCountries()
            Task { @MainActor in
                rootData = country
                dataShowing = country
            }
            endReloading()
        } catch {
            handleError(error)
        }
    }
    
}

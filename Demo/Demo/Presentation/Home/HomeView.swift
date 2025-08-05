//
//  HomeView.swift
//  Demo
//
//  Created by truong.quoc.tai on 7/29/25.
//

import SwiftUI
import SwiftUICleanArchitect

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel(gateway: CountriesGateway())
    @EnvironmentObject var viewStateManager: ViewStateManager
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var searchText: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            CustomSearchTextField(
                text: $searchText,
                placeholder: "Search Countries...",
                onCommit: {
                    viewModel.searchContries(searchText)
                }
            )
            List {
                ForEach(viewModel.dataShowing, id: \.self) { item in
                    CountryItemView(item: item)
                        .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                    
                }
            }
            .scrollIndicators(ScrollIndicatorVisibility.hidden)
            .listStyle(PlainListStyle())
            .refreshable {
                searchText = ""
                await viewModel.reloadCountries()
            }
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        .hideKeyboardOnTap()
        .onChange(of: viewModel.error) { viewStateManager.error = $0 }
        .onChange(of: viewModel.viewState) { newValue in
            viewStateManager.isLoading = newValue == .loading
        }
        .onAppear {
            guard !viewModel.firstLoadDataSuccess else { return }
            let vm = viewModel
            Task {
                await vm.getCountries()
            }
        }
        .onChange(of: searchText) { value in
            viewModel.searchContries(value)
        }
    }
}

#Preview {
    HomeView()
}

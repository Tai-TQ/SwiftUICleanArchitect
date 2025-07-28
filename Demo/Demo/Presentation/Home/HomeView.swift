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
    
    var body: some View {
        VStack {
            RefreshableListView(
                viewState: viewModel.viewState,
                refreshAction: viewModel.reloadCountries,
                content: {
                    contentView
                }
            )
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        .onChange(of: viewModel.error) { viewStateManager.error = $0 }
        .onChange(of: viewModel.viewState) { newValue in
            viewStateManager.isLoading = newValue == .loading
        }
        .onAppear {
            let vm = viewModel
            Task {
                await vm.getCountries()
            }
        }
    }
    
    
    private var contentView: some View {
        Group {
            ForEach(viewModel.data, id: \.self) { item in
                CountryItemView(item: item)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                
            }
        }
    }
}

#Preview {
    HomeView()
}

//
//  SearchFactory.swift
//  iOS-Avito-test-2024


import UIKit

protocol SearchFactory {
    func makeModule() -> UIViewController
}

struct SearchFactoryImp: SearchFactory {
    var appDIContainer: AppDIContainer

    func makeModule() -> UIViewController {
        let searchViewModel = SearchViewModel(apiService: appDIContainer.apiService,
                                              userDefaultsManager: appDIContainer.userDefaultsManager)
        let searchController = SearchViewController(viewModel: searchViewModel)
        searchController.title = "Search Media"
        return searchController
    }
}

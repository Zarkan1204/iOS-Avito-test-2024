//
//  SearchFactory.swift
//  iOS-Avito-test-2024


import UIKit

protocol SearchFactory {
    func makeScreenController(coordinator: SearchCoordinatorProtocol) -> UIViewController
    func makeDetailsCoordinator(navigation: UINavigationController, item: CollectionItem) -> DetailCoordinator
}

struct SearchFactoryImp: SearchFactory {
    var appDIContainer: AppDIContainer

    func makeScreenController(coordinator: SearchCoordinatorProtocol) -> UIViewController {
        let searchViewModel = SearchViewModel(apiService: appDIContainer.apiService,
                                              userDefaultsManager: appDIContainer.userDefaultsManager)
        let searchController = SearchViewController(coordinator: coordinator, viewModel: searchViewModel)
        searchController.title = "Search Media"
        return searchController
    }
   
    func makeDetailsCoordinator(navigation: UINavigationController, item: CollectionItem) -> DetailCoordinator {
        let detailFactory = DetailFactoryImp(appDIContainer: appDIContainer, item: item)
        let coordinator = DetailCoordinator(navigation: navigation, detailFactory: detailFactory)
        return coordinator
    }
}

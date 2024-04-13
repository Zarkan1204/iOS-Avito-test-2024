//
//  SearchCoordinator.swift
//  iOS-Avito-test-2024


import UIKit

final class SearchCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigation: UINavigationController
    let searchFactory: SearchFactory
    
    init(navigation: UINavigationController, searchFactory: SearchFactory) {
        self.navigation = navigation
        self.searchFactory = searchFactory
    }
    
    func start() {
        let controller = searchFactory.makeScreenController(coordinator: self)
        navigation.pushViewController(controller, animated: true)
    }
}

extension SearchCoordinator: ParentCoordinator { }

extension SearchCoordinator: SearchCoordinatorProtocol {
    
    func didSelect(item: CollectionItem) {
        let detailCoordinator = searchFactory.makeDetailsCoordinator(navigation: navigation, item: item)
        addChildCoordinatorStart(detailCoordinator)
    }
}


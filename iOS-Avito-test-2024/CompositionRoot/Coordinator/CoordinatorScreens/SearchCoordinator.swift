//
//  SearchCoordinator.swift
//  iOS-Avito-test-2024


import UIKit

final class SearchCoordinator: Coordinator {
    var navigation: UINavigationController
    let searchFactory: SearchFactory
    
    init(navigation: UINavigationController, searchFactory: SearchFactory) {
        self.navigation = navigation
        self.searchFactory = searchFactory
    }
    
    func start() {
        let controller = searchFactory.makeModule()
        navigation.pushViewController(controller, animated: true)
    }
}

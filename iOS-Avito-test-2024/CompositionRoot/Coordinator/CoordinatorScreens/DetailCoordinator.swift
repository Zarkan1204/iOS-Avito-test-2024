//
//  DetailCoordinator.swift
//  iOS-Avito-test-2024


import UIKit

final class DetailCoordinator: Coordinator {
    var navigation: UINavigationController
    let detailFactory: DetailFactory
    
    init(navigation: UINavigationController, detailFactory: DetailFactory) {
        self.navigation = navigation
        self.detailFactory = detailFactory
    }
    
    func start() {
        let controller = detailFactory.makeDetailController()
        navigation.pushViewController(controller, animated: true)
    }
}

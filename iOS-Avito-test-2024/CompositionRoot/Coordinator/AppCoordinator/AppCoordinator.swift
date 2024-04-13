//
//  AppCoordinator.swift
//  iOS-Avito-test-2024


import UIKit

final class AppCoordinator: Coordinator {
    var navigation: UINavigationController
    var childCoordinators: [Coordinator] = []
    private let appFactory: AppFactory?
    
    
    init(navigation: UINavigationController, appFactory: AppFactory?, window: UIWindow?) {
        self.navigation = navigation
        self.appFactory = appFactory
        configWindow(window: window)
    }
    
    func start() {
        let coordinator = appFactory?.makeSearchCoordinator(navigation: navigation)
        addChildCoordinatorStart(coordinator)
    }
    
    private func configWindow(window: UIWindow?) {
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}

extension AppCoordinator: ParentCoordinator { }


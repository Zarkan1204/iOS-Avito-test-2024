//
//  AppFactory.swift
//  iOS-Avito-test-2024


import UIKit

protocol AppFactory {
    func makeSearchCoordinator(navigation: UINavigationController) -> Coordinator
}

struct AppFactoryImp: AppFactory {
    
    let appDIContainer: AppDIContainer
    
    func makeSearchCoordinator(navigation: UINavigationController) -> Coordinator {
        let searchFactory = SearchFactoryImp(appDIContainer: appDIContainer)
        let searchCoordinator = SearchCoordinator(navigation: navigation, searchFactory: searchFactory)
        return searchCoordinator
    }
}

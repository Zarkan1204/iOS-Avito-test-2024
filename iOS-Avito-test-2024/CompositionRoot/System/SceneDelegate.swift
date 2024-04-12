//
//  SceneDelegate.swift
//  iOS-Avito-test-2024


import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: Coordinator?
    var appFactory: AppFactory?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let navigation = UINavigationController()
        let appDIContainer = AppDIContainer()
        appFactory = AppFactoryImp(appDIContainer: appDIContainer)
        window = UIWindow(windowScene: windowScene)
        appCoordinator = AppCoordinator(navigation: navigation,
                                       appFactory: appFactory,
                                       window: window)
        appCoordinator?.start()
    }
}

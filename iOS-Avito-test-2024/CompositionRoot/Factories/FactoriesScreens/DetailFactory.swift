//
//  DetailFactory.swift
//  iOS-Avito-test-2024


import UIKit

protocol DetailFactory {
    func makeDetailController() -> UIViewController
}

struct DetailFactoryImp: DetailFactory {
    
    var appDIContainer: AppDIContainer
    var item: CollectionItem

    func makeDetailController() -> UIViewController {
        let detailViewModel = DetailViewModel(apiService: appDIContainer.apiService, item: item)
        let detailController = DetailViewController(viewModel: detailViewModel)
        return detailController
    }
}

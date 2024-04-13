//
//  AppDIContainer.swift
//  iOS-Avito-test-2024


import Foundation

struct AppDIContainer {
    let networkRequest = NetworkRequest()
    let requestImage = NetworkRequestImage()
    let userDefaultsManager = UserDefaultsManager()
    let apiService: APIService
    
    init() {
        let networkFetch = NetworkFetch(networkRequest: networkRequest)
        apiService = APIService(networkFetch: networkFetch, requestImage: requestImage)
    }
}


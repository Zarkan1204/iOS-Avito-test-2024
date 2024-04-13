//
//  DetailsState.swift
//  iOS-Avito-test-2024


import Foundation

enum DetailsState {
    case initial(CollectionItem)
    case loading
    case success([LookUpItem])
    case error(String)
}

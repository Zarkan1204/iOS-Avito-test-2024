//
//  LookUpItemModel.swift
//  iOS-Avito-test-2024


import Foundation

import Foundation

// MARK: - Welcome
struct LookUpItemModel: Codable {
    let resultCount: Int
    let results: [LookUpItem]
}

// MARK: - Result
struct LookUpItem: Codable {
    let collectionViewUrl: String?
    let collectionName: String?
    let releaseDate: String?
    let artworkUrl100: String?
    var preview: Data?
}


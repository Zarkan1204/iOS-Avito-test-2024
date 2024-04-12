//
//  SearchItems.swift
//  iOS-Avito-test-2024


import Foundation

// MARK: - Welcome
struct SearchItems: Codable {
    let resultCount: Int
    let results: [SearchItem]
}

// MARK: - Result
struct SearchItem: Codable {
    let wrapperType: String
    let kind: String?
    let artworkUrl100: String?
    
    //Директор, исполнитель, диктор
    //2 свойства общие для всех ентити
    let artistName: String?
    let releaseDate: String?
    
    //movie + song
    let trackName: String?
    
    //audiobook
    let collectionName: String?
}

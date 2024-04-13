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

//name
    //movie + song
    let trackName: String?
    //audiobook
    let collectionName: String?
    
//type
    let wrapperType: String
    let kind: String?
    
//releaseDate
    let releaseDate: String?
    
//artistName
    let artistName: String?
    
//preview
    let artworkUrl100: String?
    
//description
    //movie
    let shortDescription: String?
    //audiobook
    let description: String?
    //song
    //nil
    
//trackViewUrl
    //movie + song
    let trackViewUrl: String?
    //audiobook
    let collectionViewUrl: String?
    
//artistId
    //audiobook + song
    let artistId: Int?
    //movie
    let collectionArtistId: Int?
}

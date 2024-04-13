//
//  EntityType.swift
//  iOS-Avito-test-2024


import Foundation

enum EntityType: String, CaseIterable {
    case movie
    case audiobook
    case song
    
    enum EImage: String {
        case movie = "film.circle.fill"
        case audiobook = "book.circle.fill"
        case song = "music.mic.circle.fill"
    }
    
    enum ELimit: Int, CaseIterable {
        case firstLimit = 30
        case secondLimit = 40
        case thirdLimit = 50
    }
}

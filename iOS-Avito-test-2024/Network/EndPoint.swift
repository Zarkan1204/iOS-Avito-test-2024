//
//  EndPoint.swift
//  iOS-Avito-test-2024


import Foundation

struct EndPoint {
    var name: String
    var entity: String
    var limit: Int
}

extension EndPoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"
        components.path = "/search"
        
        components.queryItems = [
            URLQueryItem(name: "term", value: name),
            URLQueryItem(name: "entity", value: entity),
            URLQueryItem(name: "limit", value: String(limit)),
            URLQueryItem(name: "country", value: "us")
        ]
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
            
        }
        return url
    }
}

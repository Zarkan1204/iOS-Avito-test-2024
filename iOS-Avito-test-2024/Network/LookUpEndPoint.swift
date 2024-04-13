//
//  LookUpEndPoint.swift
//  iOS-Avito-test-2024


import Foundation

struct LookUpEndPoint: EndPointProtocol {
    var id: Int
}

extension LookUpEndPoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"
        components.path = "/lookup"
        
        components.queryItems = [
            URLQueryItem(name: "id", value: String(id)),
            URLQueryItem(name: "entity", value: "album"),
            URLQueryItem(name: "limit", value: "5"),
            URLQueryItem(name: "sort", value: "recent")
        ]
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
            
        }
        return url
    }
}

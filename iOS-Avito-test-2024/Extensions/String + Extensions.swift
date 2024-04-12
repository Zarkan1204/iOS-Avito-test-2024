//
//  String + Extensions.swift
//  iOS-Avito-test-2024


import Foundation

extension String {
    
    func convertData() -> String {
        let isoFormatter = ISO8601DateFormatter()
        let date = isoFormatter.date(from: self)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        guard let date else { return "badFormat" }
        return dateFormatter.string(from: date)
    }
}

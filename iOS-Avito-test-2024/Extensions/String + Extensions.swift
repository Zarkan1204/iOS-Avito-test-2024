//
//  String + Extensions.swift
//  iOS-Avito-test-2024


import UIKit

extension String {
    
    func convertData() -> String {
        let isoFormatter = ISO8601DateFormatter()
        let date = isoFormatter.date(from: self)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        guard let date else { return "badFormat" }
        return dateFormatter.string(from: date)
    }

    func convertHtml() -> NSAttributedString {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ],documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    func attributedStringColor(_ words: [String],
                               color: UIColor,
                               characterSpacing: UInt? = nil) -> NSAttributedString {
        
        let attributedString = NSMutableAttributedString(string: self)
        
        words.forEach {
            let range = (self as NSString).range(of: $0)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
        
        guard let characterSpacing = characterSpacing else {
            return attributedString
        }
        
        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))
        
        return attributedString
        
    }
}

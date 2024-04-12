//
//  Reusable.swift
//  iOS-Avito-test-2024


import Foundation

protocol Reusable {
    
}

extension Reusable {
    static var reuseIdentifier: String { String(describing: self) }
}

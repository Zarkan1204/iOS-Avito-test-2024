//
//  State.swift
//  iOS-Avito-test-2024

import Foundation

enum State {
    case initial
    case loading
    case success([CollectionItem])
    case error(String)
}

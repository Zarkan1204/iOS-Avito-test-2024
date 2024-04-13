//
//  Coordinator.swift
//  iOS-Avito-test-2024


import UIKit

protocol Coordinator: AnyObject {
    var navigation: UINavigationController { get }
    func start()
}


//
//  NetworkError.swift
//  iOS-Avito-test-2024


import Foundation

enum NetworkError: Error, CustomStringConvertible {
    case urlError
    case urlSession(URLError?)
    case responseError(Int)
    case decodingError(DecodingError?)
    case unknown
    
    var description: String {
        switch self {
        case .urlError:
            return "URL Error"
        case .urlSession(let error):
            return error.debugDescription
        case .responseError(let statusCode):
            return "Response Error with status code: \(statusCode)"
        case .decodingError(let decodingError):
            return "Decoding Error: \(String(describing: decodingError))"
        case .unknown:
            return "Unknow Error"
        }
    }
    
    var localizedDescription: String {
        switch self {
        case .urlSession(let urlError):
            return urlError?.localizedDescription ?? "Something wrong"
        case .decodingError(let decodingError):
            return decodingError?.localizedDescription ?? "Something wrong"
        default:
            return "Cancel Request"
        }
    }
}


//
//  URLSession + Extensions.swift
//  iOS-Avito-test-2024


import Foundation

extension URLSession {
    
    typealias Handler = (Data?, URLResponse?, Error?) -> Void

    @discardableResult
    func request(_ endPoint: EndPointProtocol, handler: @escaping Handler) -> URLSessionDataTask {
        let task = dataTask(with: endPoint.url, completionHandler: handler)
        task.resume()
        return task
    }
}


//
//  NetworkRequest.swift
//  iOS-Avito-test-2024


import Foundation

protocol NetworkRequestProtocol {
    typealias DataError<T> = (Result<T, NetworkError>) -> Void
    func requestData(endPoint: EndPointProtocol, completion: @escaping DataError<Data>)
}

final class NetworkRequest: NetworkRequestProtocol {
    
    func requestData(endPoint: EndPointProtocol, completion: @escaping DataError<Data>) {
        URLSession.shared.request(endPoint) { data, response, error in
            if let error = error as? URLError {
                completion(.failure(.urlSession(error)))
            } else if let response = response as? HTTPURLResponse,
                      !(200...299).contains(response.statusCode) {
                completion(.failure(.responseError(response.statusCode)))
            } else {
                guard let data else { return }
                completion(.success(data))
            }
        }
    }
}

//
//  NetworkFetch.swift
//  iOS-Avito-test-2024


import Foundation

protocol NetworkFetchProtocol {
    typealias DataError<T> = (Result<T, NetworkError>) -> Void
    func fetch<T: Decodable>(type: T.Type, endPoint: EndPointProtocol, completion: @escaping DataError<T>)
}

final class NetworkFetch: NetworkFetchProtocol {

    private let networkRequest: NetworkRequestProtocol
    
    private let jsonDecoder = JSONDecoder()
    
    init(networkRequest: NetworkRequestProtocol) {
        self.networkRequest = networkRequest
    }
    
    func fetch<T: Decodable>(type: T.Type, endPoint: EndPointProtocol, completion: @escaping DataError<T>) {
        networkRequest.requestData(endPoint: endPoint) { result in
            switch result {
            case .success(let data):
                do {
                    let result = try self.jsonDecoder.decode(type, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodingError(error as? DecodingError)))
                }
            case .failure(_):
                completion(.failure(.unknown))
            }
        }
    }
}


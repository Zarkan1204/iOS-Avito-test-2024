//
//  NetworkRequestImage.swift
//  iOS-Avito-test-2024


import Foundation

protocol RequestImageProtocol {
    typealias DataError<T> = (Result<T, NetworkError>) -> Void
    func requestImageData(urlString: String, completion: @escaping DataError<Data>)
}

final class NetworkRequestImage: RequestImageProtocol {
    
    func requestImageData(urlString: String,
                                  completion: @escaping DataError<Data>) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, responce, error in
                if let error = error as? URLError {
                    completion(.failure(.urlSession(error)))
                } else {
                    guard let data else { return }
                    completion(.success(data))
                }
        }
        .resume()
    }
}

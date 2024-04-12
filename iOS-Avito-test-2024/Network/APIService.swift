//
//  APIService.swift
//  iOS-Avito-test-2024


import Foundation

final class APIService {
    
    typealias SearchItemsResults = (Result<SearchItems, NetworkError>) -> Void
    typealias DataError<T> = (Result<T, NetworkError>) -> Void
    
    private let jsonDecoder = JSONDecoder()
    
    func cancelTaskWithUrl() {
        URLSession.shared.getAllTasks { tasks in
            tasks
                .filter { $0.state == .running }
                .forEach { $0.cancel() }
        }
    }
    
    func loadSearchItems(_ searchParameters: SearchParameters,
                         completion: @escaping SearchItemsResults) {

        let categories = searchParameters.entity.map { $0.rawValue }.joined(separator: ",")
        let endPoint = EndPoint(name: searchParameters.text,
                                entity: categories,
                                limit: searchParameters.limit)
        print("Request Parameters: " + endPoint.name, endPoint.entity, endPoint.limit)
        fetch(type: SearchItems.self, endPoint: endPoint) { result in
            completion(result)
        }
    }
    
    func loadPreviewItem(urlString: String, completion: @escaping DataError<Data>) {
        requestImageData(urlString: urlString) { result in
            completion(result)
        }
    }
    
    private func fetch<T: Decodable>(type: T.Type, endPoint: EndPoint, completion: @escaping DataError<T>) {
        requestData(endPoint: endPoint) { result in
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
    
    private func requestData(endPoint: EndPoint, completion: @escaping DataError<Data>) {
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
    
    private func requestImageData(urlString: String,
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


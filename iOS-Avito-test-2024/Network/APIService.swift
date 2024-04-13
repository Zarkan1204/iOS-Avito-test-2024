//
//  APIService.swift
//  iOS-Avito-test-2024


import Foundation

final class APIService {
    
    typealias DataError<T> = (Result<T, NetworkError>) -> Void
    
    private let networkFetch: NetworkFetchProtocol
    private let requestImage: RequestImageProtocol
    
    init(networkFetch: NetworkFetchProtocol, requestImage: RequestImageProtocol) {
        self.networkFetch = networkFetch
        self.requestImage = requestImage
    }

    func cancelTaskWithUrl() {
        URLSession.shared.getAllTasks { tasks in
            tasks
                .filter { $0.state == .running }
                .forEach { $0.cancel() }
        }
    }
    
    func loadSearchItems(_ searchParameters: SearchParameters,
                         completion: @escaping DataError<SearchItems>) {

        let categories = searchParameters.entity.map { $0.rawValue }.joined(separator: ",")
        let endPoint = EndPoint(name: searchParameters.text,
                                entity: categories,
                                limit: searchParameters.limit)
        print("Request Parameters: " + endPoint.name, endPoint.entity, endPoint.limit)
        networkFetch.fetch(type: SearchItems.self, endPoint: endPoint) { result in
            completion(result)
        }
    }
    
    func loadLookupItem(id: Int, completion: @escaping DataError<LookUpItemModel>) {
        let lookUpEndPoint = LookUpEndPoint(id: id)
        networkFetch.fetch(type: LookUpItemModel.self, endPoint: lookUpEndPoint) { result in
            completion(result)
        }
    }
    
    func loadPreviewItem(urlString: String, completion: @escaping DataError<Data>) {
        requestImage.requestImageData(urlString: urlString) { result in
            completion(result)
        }
    }
}



//
//  SearchViewModel.swift
//  iOS-Avito-test-2024


import Foundation

protocol SearchViewModelProtocol {
    var state: Observable<State> { get }
    func loadData(_ searchParameters: SearchParameters)
    func saveRequestName(_ requstName: String)
    func getFiltredRequestNames(_ filterText: String) -> [String]
    func cancelRequest()
}

final class SearchViewModel: SearchViewModelProtocol {

    private var apiService: APIService
    private var userDefaultsManager: UserDefaultsManager
    private var searchItems = [SearchItem]()
    private var collectionItems = [CollectionItem]() 
    private let group = DispatchGroup()
    
    var state: Observable<State> = Observable(.initial)

    init(apiService: APIService, userDefaultsManager: UserDefaultsManager) {
        self.apiService = apiService
        self.userDefaultsManager = userDefaultsManager
    }
}

//MARK: UserDefaults

extension SearchViewModel {
    
    func saveRequestName(_ requstName: String) {
        userDefaultsManager.save(data: requstName.lowercased())
    }
    
    func getFiltredRequestNames(_ filterText: String) -> [String] {
        let lastRequestNames = userDefaultsManager.getLastRequests()
        return lastRequestNames.filter { $0.contains(filterText.lowercased())}
    }
}

//MARK: Requests

extension SearchViewModel {
    
    func loadData(_ searchParameters: SearchParameters) {
        
        guard checkSearchParameters(searchParameters) else { return }

        state.value = .loading
        apiService.loadSearchItems(searchParameters, completion: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let items):
                self.searchItems = items.results
                setCollectionItems()
                group.notify(queue: .global(), execute: {
                    self.state.value = .success(self.collectionItems)
                })
                
            case .failure(let error):
                state.value = .error(error.localizedDescription)
            }
        })
    }
    
    private func checkSearchParameters(_ searchParameters: SearchParameters) -> Bool {
        if searchParameters.text.isEmpty {
            state.value = .error("Epmty text")
            return false
        }
        if searchParameters.entity.isEmpty {
            state.value = .error("Epmty entity")
            return false
        }
        if searchParameters.limit == 0 {
            state.value = .error("Epmty limit")
            return false
        }
        return true
    }
    
    private func setCollectionItems() {
        
        collectionItems = Array(repeating: CollectionItem(), count: searchItems.count)
        
        searchItems.enumerated().forEach { (index, element) in
            
            if element.wrapperType == "audiobook" {
                let name = element.collectionName ?? "not found"
                collectionItems[index].name = name
                collectionItems[index].type = EntityType.EImage.audiobook.rawValue
                let director = "Dictor: \(element.artistName ?? "not found")"
                collectionItems[index].artistName = director
                let description = element.description
                collectionItems[index].description = description
                collectionItems[index].artistId = element.artistId ?? 0
                collectionItems[index].trackViewUrl = element.collectionViewUrl ?? ""
                
            } else if let kind = element.kind, kind == "song" {
                let name = element.trackName ?? "not found"
                collectionItems[index].name = name
                collectionItems[index].type = EntityType.EImage.song.rawValue
                let artistName = "Singer: \(element.artistName ?? "not found")"
                collectionItems[index].artistName = artistName
                collectionItems[index].artistId = element.artistId ?? 0
                collectionItems[index].trackViewUrl = element.trackViewUrl ?? ""
                
            } else {
                collectionItems[index].name = element.trackName ?? "not found"
                collectionItems[index].type = EntityType.EImage.movie.rawValue
                let director = "Director: \(element.artistName ?? "not found")"
                collectionItems[index].artistName = director
                let description = element.shortDescription
                collectionItems[index].description = description
                collectionItems[index].artistId = element.collectionArtistId ?? 0
                collectionItems[index].trackViewUrl = element.trackViewUrl ?? ""
            }
            
            let releaseDate = "Release: \(element.releaseDate?.convertData() ?? "not found")"
            collectionItems[index].releaseDate = releaseDate
            
            group.enter()
            
            if let urlStr = element.artworkUrl100 {
                
                apiService.loadPreviewItem(urlString: urlStr, completion: { [weak self] result in
                    guard let self else { return }
                    
                    switch result {
                    case .success(let data):
                        self.collectionItems[index].preview = data
                        self.group.leave()
                    case .failure(let error):
                        state.value = .error(error.localizedDescription)
                        self.group.leave()
                    }
                })
            } else {
                group.leave()
            }
        }
    }
    
    func cancelRequest() {
        apiService.cancelTaskWithUrl()
    }
}


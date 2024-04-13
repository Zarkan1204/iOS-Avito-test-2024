//
//  DetailViewModel.swift
//  iOS-Avito-test-2024


import Foundation

protocol DetailViewModelProtocol {
    var state: Observable<DetailsState> { get set }
}

final class DetailViewModel: DetailViewModelProtocol {

    private var apiService: APIService
    private let item: CollectionItem
    private var lookupItems = [LookUpItem]()
    private let group = DispatchGroup()
    var state: Observable<DetailsState> = Observable(.error("initial"))
    
    init(apiService: APIService, item: CollectionItem) {
        self.apiService = apiService
        self.item = item

        state.value = .initial(item)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.loadData()
        }
    }
    
    func loadData() {
        state.value = .loading
        apiService.loadLookupItem(id: item.artistId) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                lookupItems = data.results
                setLookUpItems()
                group.notify(queue: .global(), execute: {
                    if self.lookupItems.count > 0 {
                        self.lookupItems.removeFirst()
                    }
                    self.state.value = .success(self.lookupItems)
                })
            case .failure(let error):
                state.value = .error(error.localizedDescription)
            }
        }
    }
    
    private func setLookUpItems() {
        lookupItems.enumerated().forEach { (index, item) in
            group.enter()
            if let urlStr = item.artworkUrl100 {
                apiService.loadPreviewItem(urlString: urlStr) { [weak self] result in
                    guard let self else { return }
                    switch result {
                    case .success(let data):
                        self.lookupItems[index].preview = data
                        group.leave()
                    case .failure(let error):
                        self.state.value = .error(error.localizedDescription)
                        group.leave()
                    }
                }
            } else {
                group.leave()
            }
        }
    }
}


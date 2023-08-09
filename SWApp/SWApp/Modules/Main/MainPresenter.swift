//
// SWApp
//
// MainPresenter
//
//  Created by Olga Lidman on 2023-02-01
//
//

import Foundation

protocol MainPresenter {
    func onChangeQuery(_ query: String?)
    func onViewWillAppear()
}

class MainPresenterImpl: MainPresenter {
    // MARK: - Properties
    private let networkService: NetworkHelper
    private let storageService: StorageHelper
    private let viewController: MainController?
    private var items: [SearhableItem]
    
    // MARK: - Init
    init(viewController: MainController?,
         networkHelper: NetworkHelper,
         storageHelper: StorageHelper) {
        self.networkService = networkHelper
        self.storageService = storageHelper
        self.viewController = viewController
        self.items = []
    }
    
    // MARK: - Protocol methods
    func onChangeQuery(_ query: String?) {
        guard let query = query,
              query.isLatinLetters,
              query.count >= 2
        else {
            viewController?.show(items: [], errorOccured: false)
            return
        }
        viewController?.showLoader(true)
        let request = query.lowercased().replacingOccurrences(of: " ", with: "+")
        networkService.search(query: request) { [weak self] success, people, starships, planets in
            guard let self = self else { return }
            if !success {
                self.viewController?.show(items: [], errorOccured: true)
            } else {
                self.items = (people + starships + planets)
                var showingItems: [SearchItemModel] = []
                for item in self.items {
                    showingItems.append(SearchItemModel(description: item.description,
                                                        isFavorite: self.storageService.contains(item: item),
                                                        favButtonHandler: { self.onTapFavButton(item: item) }))
                }
                self.viewController?.show(items: showingItems, errorOccured: false)
            }
            self.viewController?.showLoader(false)
        }
    }
    
    func onViewWillAppear() {
        var showingItems: [SearchItemModel] = []
        for item in items {
            showingItems.append(SearchItemModel(description: item.description,
                                                isFavorite: self.storageService.contains(item: item),
                                                favButtonHandler: {
                self.onTapFavButton(item: item)
            }))
        }
        self.viewController?.show(items: showingItems, errorOccured: false)
    }
    
    // MARK: - Private methods
    private func onTapFavButton(item: SearhableItem) {
        storageService.handle(item: item)
    }
}

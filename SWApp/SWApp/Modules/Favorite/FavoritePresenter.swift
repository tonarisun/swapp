//
// SWApp
//
// FavoritePresenter
//
//  Created by Olga Lidman on 2023-02-01
//
//

import Foundation

protocol FavoritePresenter {
    func getItems()
}

class FavoritePresenterImpl: FavoritePresenter {
    // MARK: - Properties
    private let storageService: StorageHelper
    private var viewController: FavoriteController?
    
    // MARK: - Init
    init(viewController: FavoriteController?,
         storageHelper: StorageHelper) {
        self.viewController = viewController
        self.storageService = storageHelper
    }
    
    // MARK: - Protocol methods
    func getItems() {
        let favoriteItems = storageService.getAll()
        let showingItems = favoriteItems.map { item in
            return SearchItemModel(description: item.description, isFavorite: storageService.contains(item: item), favButtonHandler: {
                self.onTapFavButton(item: item)
            })
        }
        viewController?.show(items: showingItems)
    }
    
    // MARK: - Private methods
    private func onTapFavButton(item: SearhableItem) {
        storageService.handle(item: item)
        getItems()
    }
}

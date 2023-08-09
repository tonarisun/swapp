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
    func didSelectItem(named: String?)
}

class FavoritePresenterImpl: FavoritePresenter {
    // MARK: - Properties
    private let storageService: StorageHelper
    private var viewController: FavoriteController?
    private let router: FavoriteRouter
    private var items: [SearhableItem]
    
    // MARK: - Init
    init(viewController: FavoriteController?,
         router: FavoriteRouter,
         storageHelper: StorageHelper) {
        self.viewController = viewController
        self.storageService = storageHelper
        self.router = router
        self.items = []
    }
    
    // MARK: - Protocol methods
    func getItems() {
        items = storageService.getAll()
        let showingItems = items.map { item in
            return SearchItemModel(identifier: item.name ?? "",
                                   description: item.description,
                                   isFavorite: storageService.contains(item: item),
                                   favButtonHandler: {
                self.onTapFavButton(item: item)
            })
        }
        viewController?.show(items: showingItems)
    }
    
    func didSelectItem(named name: String?) {
        if let item = items.first(where: { $0.name == name }) {
            router.routeToItemDetails(with: item)
        }
    }
    
    // MARK: - Private methods
    private func onTapFavButton(item: SearhableItem) {
        storageService.handle(item: item)
        getItems()
    }
}

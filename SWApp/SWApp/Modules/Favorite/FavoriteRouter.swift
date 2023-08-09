//
// SWApp
//
// FavoriteRouter
//
//  Created by Olga Lidman on 2023-02-01
//
//

import UIKit

protocol FavoriteRouter {
    func routeToItemDetails(with item: SearhableItem)
}

class FavoriteRouterImpl: FavoriteRouter {
    private weak var viewController: UIViewController?
    private let detailsBuilder: DetailsBuilder
    
    init(viewController: UIViewController?,
         detailsBuilder: DetailsBuilder) {
        self.viewController = viewController
        self.detailsBuilder = detailsBuilder
    }
    
    func routeToItemDetails(with item: SearhableItem) {
        guard let controller = detailsBuilder.build(withItem: item) else { return }
        
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }
}

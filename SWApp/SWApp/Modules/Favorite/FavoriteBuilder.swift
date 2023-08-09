//
// SWApp
//
// FavoriteBuilder
//
//  Created by Olga Lidman on 2023-02-01
//
//

import UIKit

class FavoriteBuilder {
    private let dependencies: DependenciesContainer

    init(dependencies: DependenciesContainer) {
        self.dependencies = dependencies
    }
    
    func build() -> UINavigationController? {
        let storyboard = UIStoryboard(name: "Favorite", bundle: nil)
        let navController = storyboard.instantiateViewController(withIdentifier: "FavoriteViewController") as? UINavigationController
        let controller = navController?.viewControllers.first as? FavoriteViewController
        let detailsBuilder = DetailsBuilder(dependencies: dependencies)
        let router = FavoriteRouterImpl(viewController: controller,
                                        detailsBuilder: detailsBuilder)
        let presenter = FavoritePresenterImpl(viewController: controller,
                                              router: router,
                                              storageHelper: dependencies.storageHelper)
        controller?.presenter = presenter
        return navController
    }
}

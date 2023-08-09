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
    
    func build() -> FavoriteViewController? {
        let storyboard = UIStoryboard(name: "Favorite", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "FavoriteViewController") as? FavoriteViewController
        let presenter = FavoritePresenterImpl(viewController: controller, storageHelper: dependencies.storageHelper)
        controller?.presenter = presenter
        return controller
    }
}

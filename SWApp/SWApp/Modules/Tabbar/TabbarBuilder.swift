//
// SWApp
//
// TabbarBuilder
//
//  Created by Olga Lidman on 2023-02-01
//
//

import UIKit

class TabbarBuilder {
    private let dependencies: DependenciesContainer

    init(dependencies: DependenciesContainer) {
        self.dependencies = dependencies
    }
    
    func build() -> TabbarViewController? {
        let storyboard = UIStoryboard(name: "Tabbar", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "TabbarController") as? TabbarViewController
        let mainBuilder = MainBuilder(dependencies: dependencies)
        let favoriteBuilder = FavoriteBuilder(dependencies: dependencies)
        let router = TabbarRouterImpl(viewController: controller, mainBuilder: mainBuilder, favoriteBuilder: favoriteBuilder)
        let presenter = TabbarPresenterImpl(router: router)
        controller?.presenter = presenter
        return controller
    }
}

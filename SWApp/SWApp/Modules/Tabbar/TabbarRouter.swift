//
// SWApp
//
// TabbarRouter
//
//  Created by Olga Lidman on 2023-02-01
//
//

import UIKit

protocol TabbarRouter {
    func setTabs()
}

class TabbarRouterImpl: TabbarRouter {
    // MARK: - Properties
    private weak var viewController: UITabBarController?
    private let mainBuilder: MainBuilder
    private let favoriteBuilder: FavoriteBuilder
    
    // MARK: - Init
    init(viewController: UITabBarController?,
         mainBuilder: MainBuilder,
         favoriteBuilder: FavoriteBuilder) {
        self.viewController = viewController
        self.mainBuilder = mainBuilder
        self.favoriteBuilder = favoriteBuilder
    }
    
    // MARK: - Protocol methods
    func setTabs() {
        guard
            let mainController = mainBuilder.build(),
            let favoriteController = favoriteBuilder.build()
        else { return }
        mainController.tabBarItem = UITabBarItem(title: "Search",
                                                 image: UIImage(systemName: "house"),
                                                 selectedImage: UIImage(systemName: "house.fill"))
        
        favoriteController.tabBarItem = UITabBarItem(title: "Favorite",
                                                     image: UIImage(systemName: "heart"),
                                                     selectedImage: UIImage(systemName: "heart.fill"))
        
        viewController?.viewControllers = [mainController, favoriteController]
    }
}

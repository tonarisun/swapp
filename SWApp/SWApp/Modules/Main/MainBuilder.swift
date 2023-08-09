//
// SWApp
//
// MainBuilder
//
//  Created by Olga Lidman on 2023-02-01
//
//

import UIKit

class MainBuilder {
    private let dependencies: DependenciesContainer

    init(dependencies: DependenciesContainer) {
        self.dependencies = dependencies
    }
    
    func build() -> MainViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController
        let presenter = MainPresenterImpl(viewController: controller,
                                          networkHelper: dependencies.networkHelper,
                                          storageHelper: dependencies.storageHelper)
        controller?.presenter = presenter
        return controller
    }
}

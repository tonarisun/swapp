//
// SWApp
//
// DetailsBuilder
//
//  Created by Olga Lidman on 2023-02-01
//
//

import UIKit

class DetailsBuilder {
    private let dependencies: DependenciesContainer

    init(dependencies: DependenciesContainer) {
        self.dependencies = dependencies
    }
    
    func build(withItem item: SearhableItem) -> DetailsViewController? {
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
        let presenter = DetailsPresenterImpl(viewController: controller,
                                             networkHelper: dependencies.networkHelper,
                                             item: item)
        controller?.itemTitle = item.name
        controller?.presenter = presenter
        return controller
    }
}

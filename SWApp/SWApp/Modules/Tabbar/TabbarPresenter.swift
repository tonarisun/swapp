//
// SWApp
//
// TabbarPresenter
//
//  Created by Olga Lidman on 2023-02-01
//
//

import Foundation

protocol TabbarPresenter {
    func onViewDidLoad()
}

class TabbarPresenterImpl: TabbarPresenter {
    // MARK: - Properties
    let router: TabbarRouter
    
    // MARK: - Init
    init(router: TabbarRouter) {
        self.router = router
    }
    
    // MARK: - Protocol methods
    func onViewDidLoad() {
        router.setTabs()
    }
}

//
// SWApp
//
// TabbarViewController
//
//  Created by Olga Lidman on 2023-02-01
//
//

import UIKit

class TabbarViewController: UITabBarController {
    // MARK: - Properties
    var presenter: TabbarPresenter?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        presenter?.onViewDidLoad()
    }
    
    private func setupUI() {
        tabBar.tintColor = .yellow
        tabBar.unselectedItemTintColor = .lightGray
    }
}

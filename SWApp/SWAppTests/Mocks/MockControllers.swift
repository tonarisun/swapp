//
// SWAppTests
//
// MockControllers
//
//  Created by Olga Lidman on 2023-02-01
//
//

import Foundation
import SWApp
@testable import SWApp

class MockMainViewController: MainController {
    func show(items: [SearchItemModel]) {}
    func showLoader(_ show: Bool) {}
}

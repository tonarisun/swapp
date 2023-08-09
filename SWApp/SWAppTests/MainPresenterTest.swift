//
// SWAppTests
//
// MainPresenter
//
//  Created by Olga Lidman on 2023-02-01
//
//

import XCTest
@testable import SWApp

final class MainPresenterTest: XCTestCase {
    var sut: MainPresenter!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MainPresenterImpl(viewController: MockMainViewController(), networkHelper: MockNetworkService(), storageHelper: MockStorageService())
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func testExample() throws {
        sut.onChangeQuery("приивет")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

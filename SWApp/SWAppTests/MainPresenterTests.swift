//
// SWAppTests
//
// SWAppTests
//
//  Created by Olga Lidman on 2023-02-01
//
//

import XCTest
@testable import SWApp

final class MainPresenterTests: XCTestCase {
    var mainPresenter: MainPresenter!
    
    override func setUpWithError() throws {
        mainPresenter = MainPresenterImpl(viewController: MockController(),
                                          networkHelper: MockNetworkHelper(),
                                          storageHelper: MockStorageHelper())
    }

    override func tearDownWithError() throws {
        mainPresenter = nil
        try super.tearDownWithError()
    }

    func testCorrectQuery() throws {
        //given
        let query = "Luke Skywalker"
        //when
        let result = mainPresenter.onChangeQuery(query)
        //then
        XCTAssertTrue(result)
    }
    
    func testNonLatinQuery() throws {
        //given
        let query = "Люк Скайуокер"
        //when
        let result = mainPresenter.onChangeQuery(query)
        //then
        XCTAssertFalse(result)
    }
    
    func testIncorrectQuery() throws {
        //given
        let query = "%#087@@"
        //when
        let result = mainPresenter.onChangeQuery(query)
        //then
        XCTAssertFalse(result)
    }
    
    func testEmptyQuery() throws {
        //given
        let query = ""
        //when
        let result = mainPresenter.onChangeQuery(query)
        //then
        XCTAssertFalse(result)
    }
    
    func testTooShortQuery() throws {
        //given
        let query = "l"
        //when
        let result = mainPresenter.onChangeQuery(query)
        //then
        XCTAssertFalse(result)
    }
    
    func testNilQuery() throws {
        //given
        let query: String? = nil
        //when
        let result = mainPresenter.onChangeQuery(query)
        //then
        XCTAssertFalse(result)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}

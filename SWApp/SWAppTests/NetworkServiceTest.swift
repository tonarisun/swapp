//
// SWAppTests
//
// NetworkServiceTest
//
//  Created by Olga Lidman on 2023-02-01
//
//

import XCTest
@testable import SWApp

final class NetworkServiceTest: XCTestCase {
    var sut: NetworkService!

    override func setUpWithError() throws {
        sut = NetworkService()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testCorrectQuery() throws {
        let query = "Luke Skywalker"
        sut.search(query: query) { success, items in
            XCTAssert(success)
            XCTAssert(items.count == 1)
        }
    }
    
    func testIcnorrectQuery() throws {
        let emptyQuery = "xjnvlnvkjnvkxjnvjkzln"
        sut.search(query: emptyQuery) { success, items in
            XCTAssert(success)
            XCTAssert(items.isEmpty)
        }
    }
    
    func testNonLatinQuery() throws {
        let emptyQuery = "Люк"
        sut.search(query: emptyQuery) { success, items in
            XCTAssertFalse(success)
            XCTAssert(items.isEmpty)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

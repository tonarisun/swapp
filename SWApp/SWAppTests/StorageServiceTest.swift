//
// SWAppTests
//
// StorageServiceTest
//
//  Created by Olga Lidman on 2023-02-01
//
//

import XCTest
@testable import SWApp

final class StorageServiceTest: XCTestCase {
    var sut: StorageService!
    let mockItem = Planet(name: "planet", diameter: "100", population: "1", url: "planet.com")
    
    override func setUpWithError() throws {
       sut = StorageService()
    }

    override func tearDownWithError() throws {
        if sut.contains(item: mockItem) {
            sut.handle(item: mockItem)
        }
        sut = nil
        try super.tearDownWithError()
    }

    func testGetAll() throws {
        let items = sut.getAll()
        XCTAssertNotNil(items)
    }
    
    func testHandle() throws {
        if sut.contains(item: mockItem) {
            sut.handle(item: mockItem)
            XCTAssertFalse(sut.contains(item: mockItem))
        } else {
            sut.handle(item: mockItem)
            XCTAssertTrue(sut.contains(item: mockItem))
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

//
// SWAppTests
//
// Mocks
//
//  Created by Olga Lidman on 2023-02-01
//
//

@testable import SWApp

class MockController: MainController {
    func show(items: [SWApp.SearchItemModel], errorOccured: Bool) { }
    func showLoader(_ show: Bool) { }
}

class MockNetworkHelper: NetworkHelper {
    func search(query: String, completion: @escaping (Bool, [SWApp.SearhableItem]) -> Void) { }
    func getInfo(for item: SWApp.SearhableItem, completion: @escaping (Bool, [SWApp.Film]) -> Void) { }
}

class MockStorageHelper: StorageHelper {
    func getAll() -> [SWApp.SearhableItem] { [] }
    func handle(item: SWApp.SearhableItem) { }
    func contains(item: SWApp.SearhableItem) -> Bool { false }
}

//
// SWAppTests
//
// MockServices
//
//  Created by Olga Lidman on 2023-02-01
//
//
import Foundation
import SWApp
@testable import SWApp

class MockNetworkService: NetworkHelper {
    func search(query: String, completion: @escaping (Bool, [Person], [Starship], [Planet]) -> Void) {
        completion(true, [], [], [])
    }
}

class MockStorageService: StorageHelper {
    func getAll() -> [SearhableItem] {
        return []
    }
    
    func handle(item: SearhableItem) {
        
    }
    
    func contains(item: SearhableItem) -> Bool {
        return true
    }
}

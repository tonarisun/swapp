//
// SWApp
//
// StorageProtocol
//
//  Created by Olga Lidman on 2023-02-01
//
//

import Foundation

protocol StorageHelper {
    func getAll() -> [SearhableItem]
    func handle(item: SearhableItem)
    func contains(item: SearhableItem) -> Bool
}

//
// SWApp
//
// SearchItemModel
//
//  Created by Olga Lidman on 2023-02-01
//
//

struct SearchItemModel {
    enum ItemType {
        case person, starship, planet
    }
    var type: ItemType
    var description: String
    var isFavorite: Bool
}

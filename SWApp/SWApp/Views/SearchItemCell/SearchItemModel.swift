//
// SWApp
//
// SearchItemModel
//
//  Created by Olga Lidman on 2023-02-01
//
//

class SearchItemModel {
    var identifier: String
    var description: String
    var isFavorite: Bool
    var favButtonHandler: (() -> Void)?
    
    init(identifier: String,
         description: String,
         isFavorite: Bool,
         favButtonHandler: (() -> Void)?) {
        self.identifier = identifier
        self.description = description
        self.isFavorite = isFavorite
        self.favButtonHandler = favButtonHandler
    }
}

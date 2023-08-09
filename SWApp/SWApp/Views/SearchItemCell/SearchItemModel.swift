//
// SWApp
//
// SearchItemModel
//
//  Created by Olga Lidman on 2023-02-01
//
//

class SearchItemModel {
    var description: String
    var isFavorite: Bool
    var favButtonHandler: (() -> Void)?
    
    init(description: String,
         isFavorite: Bool,
         favButtonHandler: (() -> Void)?) {
        self.description = description
        self.isFavorite = isFavorite
        self.favButtonHandler = favButtonHandler
    }
}

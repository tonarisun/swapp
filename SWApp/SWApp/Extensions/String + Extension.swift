//
// SWApp
//
// String + Extension
//
//  Created by Olga Lidman on 2023-02-01
//
//

import Foundation

extension String {
    var isLatinLetters: Bool {
        NSPredicate(format: "SELF MATCHES %@", "^[a-zA-Z0-9 -]+$").evaluate(with: self)
    }
}

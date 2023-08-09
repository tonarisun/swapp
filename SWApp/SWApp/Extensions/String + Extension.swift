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
        let pattern = "[a-z A-Z0-9]"
        return (self.range(of: pattern, options:.regularExpression) != nil)
    }
}

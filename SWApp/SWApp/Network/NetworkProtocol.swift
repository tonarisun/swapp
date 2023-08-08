//
// SWApp
//
// NetworkProtocol
//
//  Created by Olga Lidman on 2023-02-01
//
//

import Foundation

protocol NetworkHelper {
    func search(query: String, completion: @escaping ([Person], [Starship], [Planet]) -> Void)
}

//
// SWApp
//
// Person
//
//  Created by Olga Lidman on 2023-02-01
//
//

import SwiftyJSON

class Person: CustomStringConvertible, SearhableItem, Codable, Equatable {
    let name: String?
    let gender: String?
    let starships: [String]
    var description: String {
        return "PERSON\nNAME: \(name ?? "unknown")\nGENDER: \(gender ?? "unknown")\nCOUNT OF STARSHIPS: \(starships.count)"
    }
    
    init(json: JSON) {
        self.name = json["name"].string
        self.gender = json["gender"].string
        self.starships = (json["starships"].arrayObject as? [String]) ?? []
    }
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        lhs.name == rhs.name
    }
}

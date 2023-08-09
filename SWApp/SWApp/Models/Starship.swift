//
// SWApp
//
// Starship
//
//  Created by Olga Lidman on 2023-02-01
//
//

import SwiftyJSON

class Starship: CustomStringConvertible, SearhableItem, Codable, Equatable {
    let name: String?
    let model: String?
    let manufacturer: String?
    let passengers: String?
    var description: String {
        return "STARSHIP\nNAME: \(name ?? "unknown")\nMODEL: \(model ?? "unknown")\nMANUFACTURER: \(manufacturer ?? "unknown")\nPASSENGERS: \(passengers ?? "unknown")"
    }
    
    init(json: JSON) {
        self.name = json["name"].string
        self.model = json["model"].string
        self.manufacturer = json["manufacturer"].string
        self.passengers = json["passengers"].string
    }
    
    static func == (lhs: Starship, rhs: Starship) -> Bool {
        lhs.name == rhs.name
    }
}

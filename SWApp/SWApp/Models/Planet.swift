//
// SWApp
//
// Planet
//
//  Created by Olga Lidman on 2023-02-01
//
//

import SwiftyJSON

class Planet: CustomStringConvertible, SearhableItem, Codable, Equatable {
    let name: String?
    let diameter: String?
    let population: String?
    let url: String?
    var description: String {
        return "PLANET\nNAME: \(name ?? "unknown")\nDIAMETER: \(diameter ?? "unknown") km\nPOPULATION: \(population ?? "unknown")"
    }
    
    init(json: JSON) {
        self.name = json["name"].string
        self.diameter = json["diameter"].string
        self.population = json["population"].string
        self.url = json["url"].string
    }
    
    init(name: String?,
         diameter: String?,
         population: String?,
         url: String?) {
        self.name = name
        self.diameter = diameter
        self.population = population
        self.url = url
    }
    
    static func == (lhs: Planet, rhs: Planet) -> Bool {
        lhs.name == rhs.name
    }
}

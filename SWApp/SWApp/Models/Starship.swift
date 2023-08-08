//
// SWApp
//
// Starship
//
//  Created by Olga Lidman on 2023-02-01
//
//

import SwiftyJSON

struct Starship: CustomStringConvertible {
    var name: String?
    var manufacturer: String?
    var passengers: String?
    
    var description: String {
        return "STARSHIP\nNAME: \(name ?? "unknown")\nMANUFACTURER: \(manufacturer ?? "unknown")\nPASSENGERS: \(passengers ?? "unknown")"
    }
    
    init(json: JSON) {
        self.name = json["name"].string
        self.manufacturer = json["manufacturer"].string
        self.passengers = json["passengers"].string
    }
}

/*
 "MGLT": "10 MGLT",
 "cargo_capacity": "1000000000000",
 "consumables": "3 years",
 "cost_in_credits": "1000000000000",
 "created": "2014-12-10T16:36:50.509000Z",
 "crew": "342953",
 "edited": "2014-12-10T16:36:50.509000Z",
 "hyperdrive_rating": "4.0",
 "length": "120000",
 "manufacturer": "Imperial Department of Military Research, Sienar Fleet Systems",
 "max_atmosphering_speed": "n/a",
 "model": "DS-1 Orbital Battle Station",
 "name": "Death Star",
 "passengers": "843342",
 "films": [
     "https://swapi.dev/api/films/1/"
 ],
 "pilots": [],
 "starship_class": "Deep Space Mobile Battlestation",
 "url": "https://swapi.dev/api/starships/9/"
 */

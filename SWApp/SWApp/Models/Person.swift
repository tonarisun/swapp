//
// SWApp
//
// Person
//
//  Created by Olga Lidman on 2023-02-01
//
//

import SwiftyJSON

struct Person: CustomStringConvertible {
    var name: String?
    var gender: String?
    var starships: [String]
    
    var description: String {
        return "PERSON\nNAME: \(name ?? "unknown")\nGENDER: \(gender ?? "unknown")\nCOUNT OF STARSHIPS: \(starships.count)"
    }
    
    init(json: JSON) {
        self.name = json["name"].string
        self.gender = json["gender"].string
        self.starships = (json["starships"].arrayObject as? [String]) ?? []
    }
}
/*
 {
     "birth_year": "19 BBY",
     "eye_color": "Blue",
     "films": [
         "https://swapi.dev/api/films/1/",
         ...
     ],
     "gender": "Male",
     "hair_color": "Blond",
     "height": "172",
     "homeworld": "https://swapi.dev/api/planets/1/",
     "mass": "77",
     "name": "Luke Skywalker",
     "skin_color": "Fair",
     "created": "2014-12-09T13:50:51.644000Z",
     "edited": "2014-12-10T13:52:43.172000Z",
     "species": [
         "https://swapi.dev/api/species/1/"
     ],
     "starships": [
         "https://swapi.dev/api/starships/12/",
         ...
     ],
     "url": "https://swapi.dev/api/people/1/",
     "vehicles": [
         "https://swapi.dev/api/vehicles/14/"
         ...
     ]
 }
 */

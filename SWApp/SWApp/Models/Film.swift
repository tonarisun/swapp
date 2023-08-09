//
// SWApp
//
// Film
//
//  Created by Olga Lidman on 2023-02-01
//
//

import SwiftyJSON

class Film: SearhableItem {
    let name: String?
    let url: String?
    let episodeID: Int?
    let director: String?
    let producer: String?
    var description: String {
        return "\(name?.uppercased() ?? "unknown")\nEpisode \(episodeID ?? 0)\nDirector: \(director ?? "unknown")\nProducer: \(producer ?? "unknown")"
    }
    
    init(json: JSON) {
        self.name = json["title"].string
        self.url = json["url"].string
        self.episodeID = json["episode_id"].int
        self.director = json["director"].string
        self.producer = json["producer"].string
    }
}

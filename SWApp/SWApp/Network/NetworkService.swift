//
// SWApp
//
// NetworkService
//
//  Created by Olga Lidman on 2023-02-01
//
//

import Foundation
import SwiftyJSON

class NetworkService: NetworkHelper {
    
    enum Endpoint: String {
        case films =     "films/"
        case people =    "people/"
        case starships = "starships/"
        case planets =   "planets/"
        case search =    "?search="
        
        var baseUrl: String {
            return "https://swapi.dev/api/"
        }
        
        var searchUrl: String {
            return baseUrl + self.rawValue + Endpoint.search.rawValue
        }
    }
    
    private let baseUrl = "https://swapi.dev/api/"
    private var searchOperation: CancellableOperation?
    
    func search(query: String, completion: @escaping ([Person], [Starship], [Planet]) -> Void) {
        guard
            let searchPeopleUrl = URL(string: Endpoint.people.searchUrl + query),
            let searchStarshipsUrl = URL(string: Endpoint.starships.searchUrl + query),
            let searchPlanetUrl = URL(string: Endpoint.planets.searchUrl + query)
        else {
            fatalError("Invalid URL for: search")
        }
        
        if searchOperation?.isExecuting ?? false {
            searchOperation?.cancel()
        }
        
        var people = [Person]()
        var starships = [Starship]()
        var planets = [Planet]()
        
        let peopleBlock = BlockOperation {
            if let data = try? Data(contentsOf: searchPeopleUrl),
               let json = try? JSON(data: data),
               let results = json["results"].array,
               !results.isEmpty {
                people = results.map({ Person(json: $0) })
            }
        }
        let starshipsBlock = BlockOperation {
            if let data = try? Data(contentsOf: searchStarshipsUrl),
               let json = try? JSON(data: data),
               let results = json["results"].array,
               !results.isEmpty {
                starships = results.map({ Starship(json: $0) })
            }
        }
        let planetsBlock = BlockOperation {
            if let data = try? Data(contentsOf: searchPlanetUrl),
               let json = try? JSON(data: data),
               let results = json["results"].array,
               !results.isEmpty {
                planets = results.map({ Planet(json: $0) })
            }
        }
        searchOperation = CancellableOperation(operations: [peopleBlock, starshipsBlock, planetsBlock],
                                               completion: {
            completion(people, starships, planets)
        })
        searchOperation?.start()
    }
}



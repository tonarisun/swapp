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
    
    func search(query: String, completion: @escaping (Bool, [SearhableItem]) -> Void) {
        let request = query.lowercased().replacingOccurrences(of: " ", with: "+")
        guard
            let searchPeopleUrl = URL(string: Endpoint.people.searchUrl + request),
            let searchStarshipsUrl = URL(string: Endpoint.starships.searchUrl + request),
            let searchPlanetUrl = URL(string: Endpoint.planets.searchUrl + request)
        else {
            completion(false, [])
            return
        }
        
        if searchOperation?.isExecuting ?? false {
            searchOperation?.cancel()
        }
        
        var people = [Person]()
        var starships = [Starship]()
        var planets = [Planet]()
        var errorsCount = 0
        
        let peopleBlock = BlockOperation {
            if let data = try? Data(contentsOf: searchPeopleUrl),
               let json = try? JSON(data: data),
               let results = json["results"].array {
                people = results.map({ Person(json: $0) })
            } else {
                errorsCount += 1
            }
        }
        let starshipsBlock = BlockOperation {
            if let data = try? Data(contentsOf: searchStarshipsUrl),
               let json = try? JSON(data: data),
               let results = json["results"].array {
                starships = results.map({ Starship(json: $0) })
            } else {
                errorsCount += 1
            }
        }
        let planetsBlock = BlockOperation {
            if let data = try? Data(contentsOf: searchPlanetUrl),
               let json = try? JSON(data: data),
               let results = json["results"].array {
                planets = results.map({ Planet(json: $0) })
            } else {
                errorsCount += 1
            }
        }
        searchOperation = CancellableOperation(operations: [peopleBlock, starshipsBlock, planetsBlock],
                                               completion: {
            if errorsCount == 3 {
                completion(false, [])
            } else {
                completion(true, people+starships+planets)
            }
        })
        searchOperation?.start()
    }
}



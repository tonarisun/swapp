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
    // MARK: - Endpoint enum
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
    
    // MARK: - Properties
    private let baseUrl = "https://swapi.dev/api/"
    private var searchOperation: CancellableOperation?
    
    // MARK: - Search
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
    
    // MARK: - Get info
    func getInfo(for item: SearhableItem, completion: @escaping (Bool, [Film]) -> Void) {
        guard let urlString = item.url,
              let url = URL(string: urlString)
        else {
            completion(false, [])
            return
        }
        var films = [Film]()
        var errorOccured = false
        let concurrentQueue = DispatchQueue(label: "get.info.concurrent.queue", attributes: .concurrent)
        concurrentQueue.async {
            guard let data = try? Data(contentsOf: url),
                  let json = try? JSON(data: data),
                  let filmUrls = json["films"].arrayObject as? [String] else {
                completion(false, [])
                return
            }
            let group = DispatchGroup()
            for url in filmUrls {
                group.enter()
                concurrentQueue.async {
                    if let url = URL(string: url),
                       let data = try? Data(contentsOf: url),
                       let json = try? JSON(data: data) {
                        films.append(Film(json: json))
                    } else {
                        errorOccured = true
                    }
                    group.leave()
                }
            }
            group.notify(queue: .main) {
                completion(!errorOccured, films)
            }
        }
    }
}



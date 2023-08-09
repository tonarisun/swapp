//
// SWApp
//
// StorageService
//
//  Created by Olga Lidman on 2023-02-01
//
//

import Foundation

class StorageService: StorageHelper {
    private let defaults = UserDefaults.standard
    private let peopleKey = "kFavoritePeople"
    private let starshipsKey = "kFavoriteStarships"
    private let planetsKey = "kFavoritePlanets"
    
    func getAll() -> [SearhableItem] {
        let people: [Person] = load(forKey: peopleKey)
        let starships: [Starship] = load(forKey: starshipsKey)
        let planets: [Planet] = load(forKey: planetsKey)
        return people + starships + planets
    }
    
    func handle(item: SearhableItem) {
        if let person = item as? Person {
            handlePerson(person)
            return
        }
        if let starship = item as? Starship {
            handleStarship(starship)
            return
        }
        if let planet = item as? Planet {
            handlePlanet(planet)
        }
    }

    func contains(item: SearhableItem) -> Bool {
        if let person = item as? Person {
            let people: [Person] = load(forKey: peopleKey)
            return people.contains(person)
        }
        if let starship = item as? Starship {
            let starships: [Starship] = load(forKey: starshipsKey)
            return starships.contains(starship)
        }
        if let planet = item as? Planet {
            let planets: [Planet] = load(forKey: planetsKey)
            return planets.contains(planet)
        }
        return false
    }
    
    private func handlePerson(_ person: Person) {
        var people: [Person] = load(forKey: peopleKey)
        if people.contains(person) {
            people.removeAll(where: { $0 == person })
        } else {
            people.append(person)
        }
        save(people, forKey: peopleKey)
    }
    
    private func handleStarship(_ starship: Starship) {
        var starships: [Starship] = load(forKey: starshipsKey)
        if starships.contains(starship) {
            starships.removeAll(where: { $0 == starship })
        } else{
            starships.append(starship)
        }
        save(starships, forKey: starshipsKey)
    }
    
    private func handlePlanet(_ planet: Planet) {
        var planets: [Planet] = load(forKey: planetsKey)
        if planets.contains(planet) {
            planets.removeAll(where: { $0 == planet })
        } else {
            planets.append(planet)
        }
        save(planets, forKey: planetsKey)
    }
    
//    private func addNew<T: Codable>(_ type: T.Type, item: T, forKey key: String) {
//        var currentValue: [T] = load(forKey: key)
//        if !currentValue.contains(where: item) {
//            currentValue.append(item)
//            save(currentValue, forKey: key)
//        }
//    }
    
    private func load<T: Codable>(forKey key: String) -> [T] {
        guard let encodedData = UserDefaults.standard.array(forKey: key) as? [Data] else {
            return []
        }
        return encodedData.map { try! JSONDecoder().decode(T.self, from: $0) }
    }
    
    private func save<T: Codable>(_ items: [T], forKey key: String) {
        let data = items.map { try? JSONEncoder().encode($0) }
        UserDefaults.standard.set(data, forKey: key)
    }
}



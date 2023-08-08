//
// SWApp
//
// MainPresenter
//
//  Created by Olga Lidman on 2023-02-01
//
//

import Foundation

protocol MainPresenter {
    func onChangeQuery(_ query: String?)
    func onTapFavButton()
}

class MainPresenterImpl: MainPresenter {
    private let networkService: NetworkHelper
    private var model: MainModel
    private let viewController: MainController
    
    init(viewController: MainController) {
        self.networkService = NetworkService()
        self.model = MainModel()
        self.viewController = viewController
    }
    
    func onChangeQuery(_ query: String?) {
        guard let query = query,
              query.count >= 2
        else {
            return
        }
        networkService.search(query: query.lowercased()) { people, starships, planets in
            self.model.people = people
            self.model.starships = starships
            self.model.planets = planets
            self.viewController.show(data: self.model)
        }
    }
    
    func onTapFavButton() {
        
    }
}

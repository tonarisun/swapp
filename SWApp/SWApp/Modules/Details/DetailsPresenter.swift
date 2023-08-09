//
// SWApp
//
// DetailsPresenter
//
//  Created by Olga Lidman on 2023-02-01
//
//

import Foundation

protocol DetailsPresenter {
    func onViewDidLoad()
}

class DetailsPresenterImpl: DetailsPresenter {
    // MARK: - Properties
    private let networkService: NetworkHelper
    private let viewController: DetailsController?
    private let item: SearhableItem
    
    // MARK: - Init
    init(viewController: DetailsController?,
         networkHelper: NetworkHelper,
         item: SearhableItem) {
        self.viewController = viewController
        self.networkService = networkHelper
        self.item = item
    }
    
    // MARK: - Protocol methods
    func onViewDidLoad() {
        viewController?.showLoader(true)
        networkService.getInfo(for: item) { [weak self] success, films in
            if success {
                self?.viewController?.show(films: films.sorted(by: { ($0.episodeID ?? 0) < ($1.episodeID ?? 0) }))
            }
            self?.viewController?.showLoader(false)
        }
    }
}

//
// SWApp
//
// ViewController
//
//  Created by Olga Lidman on 2023-02-01
//
//

import UIKit

protocol MainController {
    func show(data: MainModel)
}

class MainViewController: UIViewController, MainController {
    // MARK: -  UI
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(SearchItemTableViewCell.self, forCellReuseIdentifier: SearchItemTableViewCell.identifier)
        table.rowHeight = 150
        table.separatorStyle = .none
        return table
    }()
    
    // MARK: - Properties
    private var models = [SearchItemModel]()
    private var presenter: MainPresenter?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = MainPresenterImpl(viewController: self)
        setupUI()
    }
    
    private func setupUI() {
        searchBar.delegate = self
        view.addSubview(searchBar)
        searchBar.setConstraints([.topToTop(10), .centerX(), .leftToLeft(10), .rightToRight(-10)], to: view)
//        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
//        searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        searchBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: -20).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.setConstraints([.topToBottom(20)], to: searchBar)
        tableView.setConstraints([.leftToLeft(), .rightToRight(), .bottomToBottom()], to: view)
//        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
//        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    // MARK: - Protocol methods
    func show(data: MainModel) {
        models.removeAll()
        data.people.forEach { person in
            models.append(SearchItemModel(type: .person, description: person.description, isFavorite: false))
        }
        data.starships.forEach { starship in
            models.append(SearchItemModel(type: .starship, description: starship.description, isFavorite: false))
        }
        data.planets.forEach { planet in
            models.append(SearchItemModel(type: .planet, description: planet.description, isFavorite: false))
        }
        tableView.reloadData()
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.onChangeQuery(searchText)
    }
}

extension MainViewController: UITableViewDelegate {
    
}

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SearchItemTableViewCell.identifier, for: indexPath) as? SearchItemTableViewCell {
            cell.construct(withModel: models[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

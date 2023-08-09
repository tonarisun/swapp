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
    func show(items: [SearchItemModel], errorOccured: Bool)
    func showLoader(_ show: Bool)
}

class MainViewController: UIViewController, MainController {
    // MARK: -  UI
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.tintColor = .yellow
        searchBar.searchTextField.textColor = .white
        searchBar.keyboardAppearance = .dark
        searchBar.placeholder = "Search..."
        return searchBar
    }()
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(SearchItemTableViewCell.self, forCellReuseIdentifier: SearchItemTableViewCell.identifier)
        table.separatorStyle = .none
        table.rowHeight = 200
        return table
    }()
    private let loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .large)
        loader.hidesWhenStopped = true
        loader.color = .yellow
        return loader
    }()
    private let emptyView: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .yellow
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    // MARK: - Properties
    private var models = [SearchItemModel]()
    var presenter: MainPresenter?
    private var errorOccured = false
    private let emptyListText = "A long time ago \nin a galaxy far, far away....\nnothing was found.\nUse search bar to find\nwhat you are looking for,\nyoung jedi"
    private let errorText = "Ooops...something went wrong.\nDon't give up, try again later"
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.onViewWillAppear()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        searchBar.delegate = self
        view.addSubview(searchBar)
        searchBar.setConstraints([.topToTop(10), .centerX(), .leftToLeft(10), .rightToRight(-10), .height(40)], to: view)

        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.setConstraints([.topToBottom(20)], to: searchBar)
        tableView.setConstraints([.leftToLeft(), .rightToRight(), .bottomToBottom()], to: view)
        tableView.backgroundColor = .clear
        
        view.addSubview(loader)
        loader.backgroundColor = .black
        loader.setConstraints([.centerX(), .centerY()], to: view)
        
        view.addSubview(emptyView)
        emptyView.setConstraints([.topToTop(), .leftToLeft(), .rightToRight(), .bottomToBottom()], to: tableView)
        emptyView.setSpacedText(emptyListText,
                                color: .yellow,
                                alignment: .center)
    }
    
    // MARK: - Protocol methods
    func show(items: [SearchItemModel], errorOccured: Bool) {
        if errorOccured {
            emptyView.setSpacedText(errorText,
                                    color: .yellow,
                                    alignment: .center)
        } else {
            emptyView.setSpacedText(emptyListText,
                                    color: .yellow,
                                    alignment: .center)
        }
        models = items
        tableView.reloadData()
    }
    
    func showLoader(_ show: Bool) {
        if show {
            loader.startAnimating()
        } else {
            loader.stopAnimating()
        }
    }
}

// MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.onChangeQuery(searchText)
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptyView.isHidden = !models.isEmpty
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SearchItemTableViewCell.identifier, for: indexPath) as? SearchItemTableViewCell {
            cell.construct(withModel: models[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

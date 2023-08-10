//
// SWApp
//
// DetailsViewController
//
//  Created by Olga Lidman on 2023-02-01
//
//

import UIKit

protocol DetailsController {
    func show(films: [Film])
    func showLoader(_ show: Bool)
}

class DetailsViewController: UIViewController, DetailsController {
    // MARK: - UI
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(FilmInfoTableCell.self, forCellReuseIdentifier: FilmInfoTableCell.identifier)
        table.separatorStyle = .none
        table.rowHeight = 100
        return table
    }()
    private let loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .large)
        loader.hidesWhenStopped = true
        loader.color = .yellow
        return loader
    }()
    
    // MARK: - Properties
    var presenter: DetailsPresenter?
    var itemTitle: String?
    var models = [FilmInfoModel]()
    private let errorText = "Error occured... don't give up and try again later"
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        presenter?.onViewDidLoad()
    }
    
    private func setupUI() {
        let label = UILabel()
        label.textColor = .yellow
        label.text = itemTitle
        navigationItem.titleView = label
        view.backgroundColor = .black
        
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.setConstraints([.topToTop(), .leftToLeft(), .rightToRight(), .bottomToBottom()], to: view)
        tableView.backgroundColor = .clear
        
        view.addSubview(loader)
        loader.setConstraints([.centerX(), .centerY()], to: view)
    }
    
    // MARK: - Protocol methods
    func show(films: [Film]) {
        models = films.map({ FilmInfoModel(info: $0.description) })
        if films.isEmpty {
            models = [FilmInfoModel(info: errorText)]
        }
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

// MARK: - UITableViewDataSource
extension DetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: FilmInfoTableCell.identifier, for: indexPath) as? FilmInfoTableCell {
            cell.construct(model: models[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

//
// SWApp
//
// FavoriteViewController
//
//  Created by Olga Lidman on 2023-02-01
//
//

import UIKit

protocol FavoriteController {
    func show(items: [SearchItemModel])
}

class FavoriteViewController: UIViewController, FavoriteController {
    // MARK: - UI
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .yellow
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "FAVORITES"
        label.textAlignment = .center
        return label
    }()
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(SearchItemTableViewCell.self, forCellReuseIdentifier: SearchItemTableViewCell.identifier)
        table.separatorStyle = .none
        table.rowHeight = 200
        return table
    }()
    private let emptyView: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.setSpacedText("Nothing is here...\nAdd some stuff to favorites list\nand may the Force be with you",
                            color: .yellow,
                            alignment: .center)
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    // MARK: - Properties
    private var models = [SearchItemModel]()
    var presenter: FavoritePresenter?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = FavoritePresenterImpl(viewController: self, storageHelper: StorageService())
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.getItems()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
        
        view.addSubview(titleLabel)
        titleLabel.setConstraints([.topToTop(), .leftToLeft(), .rightToRight(), .height(40)], to: view)
        
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.setConstraints([.topToBottom(10)], to: titleLabel)
        tableView.setConstraints([.leftToLeft(), .rightToRight(), .bottomToBottom()], to: view)
        tableView.backgroundColor = .clear
        
        view.addSubview(emptyView)
        emptyView.setConstraints([.topToTop(), .leftToLeft(), .rightToRight(), .bottomToBottom()], to: tableView)
    }
    
    // MARK: - Protocol methods
    func show(items: [SearchItemModel]) {
        models = items
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension FavoriteViewController: UITableViewDataSource {
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

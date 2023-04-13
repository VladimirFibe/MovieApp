//
//  FavouriteViewController.swift
//  MovieApp
//
//  Created by Павел Грицков on 12.04.23.
//

import UIKit

class FavouriteViewController: BaseViewController {
    
    private let heightRow: CGFloat = 184.0
    
    let tableView = UITableView(frame: .zero, style: .plain)
    var results: [Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setConstraints()
    }
    
    func configureUI() {
        navigationItem.title = "Favourite"
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.register(ContentCell.self, forCellReuseIdentifier: String(describing: ContentCell.self))
        tableView.rowHeight = heightRow
        
        }
    
    func setConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - TableView Data Source
extension FavouriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ContentCell.self)) as! ContentCell
        cell.configure(title: "Avatar", date: "", duration: "")
        return cell
    }
}

// MARK: - TableView Delegate
extension FavouriteViewController: UITableViewDelegate {
    
}

extension FavouriteViewController {
    
}

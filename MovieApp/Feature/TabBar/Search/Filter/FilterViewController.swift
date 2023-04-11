//
//  FilterViewController.swift
//  MovieApp
//
//  Created by Павел Грицков on 09.04.23.
//

import UIKit

class FilterViewController: UIViewController {
    
    private let radiusParentView: CGFloat = 24
    let tableView = UITableView(frame: .zero, style: .plain)
    
    private let cellCount = 4
    
    private var rowHeight: CGFloat {
        let halfView = view.frame.height / 2
        let offsetBottom = view.safeAreaInsets.bottom
        let offsetTop = radiusParentView / 2
        return (halfView - (offsetBottom + offsetTop)) / CGFloat(cellCount)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setConstraints()

    }
    
    // MARK: - Private Methods
    private func configureUI() {
        view.backgroundColor = Theme.whiteToBlack
        view.layer.cornerRadius = radiusParentView
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.rowHeight = rowHeight
    }
    
    private func setConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: radiusParentView),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - TableView DataSource
extension FilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch indexPath.row {
        case 0: cell.contentView.backgroundColor = .blue.withAlphaComponent(1.0)
        case 1: cell.contentView.backgroundColor = .blue.withAlphaComponent(0.8)
        case 2: cell.contentView.backgroundColor = .blue.withAlphaComponent(0.6)
        case 3: cell.contentView.backgroundColor = .blue.withAlphaComponent(0.4)
        default: break
        }
        return cell
    }
}

// MARK: - Table ViewDelegate
extension FilterViewController: UITableViewDelegate {
    
}

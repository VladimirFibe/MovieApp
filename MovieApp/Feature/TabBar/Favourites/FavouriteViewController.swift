//
//  FavouriteViewController.swift
//  MovieApp
//
//  Created by Павел Грицков on 12.04.23.
//

import UIKit

struct Testeble {
    var title: String
    var date: String
    var duration: String
    var isFavourite: Bool
}

class FavouriteViewController: BaseViewController {
    
    private let heightRow: CGFloat = 184.0
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    var testArray: [Testeble] = [
        .init(title: "Avatar", date: "12-12-1999", duration: "123 Minutes", isFavourite: true),
        .init(title: "Avatar", date: "12-12-1999", duration: "123 Minutes", isFavourite: false),
        .init(title: "Avatar", date: "12-12-1999", duration: "123 Minutes", isFavourite: true),
        .init(title: "Avatar", date: "12-12-1999", duration: "123 Minutes", isFavourite: false),
        .init(title: "Avatar", date: "12-12-1999", duration: "123 Minutes", isFavourite: true),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setConstraints()
    }
    
    func configureUI() {
        navigationItem.title = "Favourite"
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ContentCell.self, forCellReuseIdentifier: String(describing: ContentCell.self))
        tableView.rowHeight = heightRow
        
        tableView.separatorStyle = .none
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
        return testArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ContentCell.self)) as! ContentCell
        
        let title = testArray[indexPath.row].title
        let duration = testArray[indexPath.row].duration
        let date = testArray[indexPath.row].date
        let isFavourite = testArray[indexPath.row].isFavourite
        
        cell.configure(title: title, date: date, duration: duration, isFavourite: isFavourite)
        cell.delegate = self
        return cell
    }
}

// MARK: - TableView Delegate
extension FavouriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //  TODO: Тут осуществить переход на экран детальной информации
        print("the cell with the index path \(indexPath) is selected")
    }
}

// MARK: - Content Cell Delegate
extension FavouriteViewController: ContentCellDelegate {
    func cellFavouriteButtonDidPress(cell: ContentCell, button: UIButton) {
        // TODO: Тут обрабатывать нажатие кнопки издранное
    }
}

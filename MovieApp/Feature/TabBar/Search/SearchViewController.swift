//
//  SearchViewController.swift
//  MovieApp
//
//  Created by Dmitriy Babichev on 09.04.2023.
//

import UIKit

class SearchViewController: BaseViewController {

    let searchController = UISearchController()
    let tableView = UITableView()
    
    let presentationManager = PresentationManager()

    var results = [Result]()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigation()
        configureTableView()
        configureSearchController()
        addSubViews()
        setConstraints()
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ContentCell.self, forCellReuseIdentifier: String(describing: ContentCell.self))
        tableView.separatorStyle = .none
    }

    func configureSearchController() {
        let image = UIImage(systemName: "slider.horizontal.3")
        searchController.searchBar.setImage(image, for: .bookmark, state: .normal)
        searchController.searchBar.showsBookmarkButton = true
        searchController.searchBar.delegate = self
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Enter the movie name"
        definesPresentationContext = true
    }

    func configureNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    func addSubViews() {
        view.addSubview(tableView)
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        APIService.shared.getMovies(for: query.trimmingCharacters(in: .whitespaces)) { results, error in
            if let results = results {
                self.results = results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ContentCell.self)) as! ContentCell

        let data = results[indexPath.row]
        
        cell.configure(title: "DriftingHome", date: data.releaseDate, duration: "148 Minutes", isFavourite: false)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        184
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped!")
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        let vc = FilterViewController()
        
        // задаем направлени презентации VC
        presentationManager.direction = .bottom
        vc.transitioningDelegate = presentationManager
        vc.modalPresentationStyle = .custom
        
        present(vc, animated: true)
    }
}

//
//  FavouritesViewController.swift
//  MovieApp
//
//  Created by Artur Imanbaev on 04.04.2023.
//

import Foundation
import UIKit
final class FavouritesViewController: UIViewController{
    let movieTable = MovieTableView()
    let horizontalMenuCollectionView = HorizontalTagCollectionView()
    var movieArray: [Result] = []
    let apiCall = "https://api.themoviedb.org/3/discover/movie?api_key=6b8a95b1b6c4eeede348d430f4a88303"
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        horizontalMenuCollectionView.cellDelegate = self
        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRequest()
    }
    func fetchRequest(){
        APICaller.shared.fetchRequest(urlString: apiCall, expecting: Welcome.self) { (movieDetails) in
            movieDetails.results.forEach({print($0.originalTitle)})
                self.movieTable.movieInfos = movieDetails.results
                DispatchQueue.main.async {
                    self.movieTable.reloadData()
                }
            }
    }
    func setupUI(){
        view.addSubview(movieTable)
        NSLayoutConstraint.activate([
            movieTable.topAnchor.constraint(equalTo: view.topAnchor, constant: 165),
            movieTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            movieTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            view.trailingAnchor.constraint(equalTo: movieTable.trailingAnchor, constant: 25),
        ])
        view.addSubview(horizontalMenuCollectionView)
        NSLayoutConstraint.activate([
            horizontalMenuCollectionView.bottomAnchor.constraint(equalTo: movieTable.topAnchor,constant: -40),
            horizontalMenuCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            horizontalMenuCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            horizontalMenuCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
}
extension FavouritesViewController: SelectCollectionViewItemProtocol{
    func selectItem(_ index: IndexPath) {
            fetchRequest()
    }
}

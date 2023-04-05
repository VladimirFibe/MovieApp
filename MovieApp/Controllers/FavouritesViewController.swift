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
    var movieDict: [Int: [MovieModel]] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        horizontalMenuCollectionView.cellDelegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let movie = MovieModel()
        movie.name = "Adventure"
        movieDict[2] = [movie]
        let movie1 = MovieModel()
        movie1.name = "All"
        let movie2 = MovieModel()
        movie2.name = "All"
        movieDict.updateValue([movie1, movie2], forKey: 0)
        movieTable.movieInfos = movieDict[0]!
        movieTable.reloadData()
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
            movieTable.movieInfos = movieDict[index.item]!
            movieTable.reloadData()
    }
}

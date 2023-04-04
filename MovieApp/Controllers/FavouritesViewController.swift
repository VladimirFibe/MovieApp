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
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        horizontalMenuCollectionView.cellDelegate = self
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
        if index.item == 2{
            movieTable.items = 2
        }
        else {
            movieTable.items = 8
        }
        movieTable.reloadData()
    }
}

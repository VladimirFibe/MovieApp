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
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTable.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieCellId")
        setupUI()
    }
    func setupUI(){
        view.addSubview(movieTable)
        NSLayoutConstraint.activate([
            movieTable.topAnchor.constraint(equalTo: view.topAnchor, constant: 165),
            movieTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            movieTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            view.trailingAnchor.constraint(equalTo: movieTable.trailingAnchor, constant: 25),
        ])
    }
}

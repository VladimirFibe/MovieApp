//
//  MovieTableView.swift
//  MovieApp
//
//  Created by Artur Imanbaev on 04.04.2023.
//

import UIKit

class MovieTableView: UITableView {
    var movieInfos: [MovieModel] = []
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.dataSource = self
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.rowHeight = 200
        self.register(MovieTableViewCell.self, forCellReuseIdentifier: "MovieCellId")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: delegets data Source methods
extension MovieTableView: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = dequeueReusableCell(withIdentifier: Constants.cellMovieIdentifier, for: indexPath) as? MovieTableViewCell{
            cell.movieTitle.text = movieInfos[indexPath.row].name
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}

//
//  MovieTableView.swift
//  MovieApp
//
//  Created by Artur Imanbaev on 04.04.2023.
//

import UIKit

class MovieTableView: UITableView {
    var movieInfos: [Result]?
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
        return movieInfos?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = dequeueReusableCell(withIdentifier: Constants.cellMovieIdentifier, for: indexPath) as? MovieTableViewCell{
//            APICaller.shared.fetchRequest(urlString: "https://image.tmdb.org/t/p/w500\(movieInfos?[indexPath.row].posterPath)", expecting: Data.self) { posterResult in
//                cell.moviePoster.image = UIImage(data: posterResult)
//            }
            let stringURL = "https://image.tmdb.org/t/p/w500\(String(describing: movieInfos![indexPath.row].posterPath))"
            print(stringURL)
            let url = URL(string: stringURL)

            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    cell.moviePoster.image = UIImage(data: data!)
                }
            }
            cell.movieTitle.text = movieInfos?[indexPath.row].originalTitle
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

}

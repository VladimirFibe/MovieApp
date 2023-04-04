//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by Artur Imanbaev on 04.04.2023.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    let infoImagesArray: [String] = ["stopwatch","calendar","popcorn"]
    let moviePoster: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.image = UIImage(systemName: "square")
        return $0
    }(UIImageView())
    let movieTitle: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "hello"
        $0.font = .systemFont(ofSize: 15)
        return $0
    }(UILabel())
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupUI(){
        self.contentView.addSubview(moviePoster)
        NSLayoutConstraint.activate([
            self.contentView.bottomAnchor.constraint(equalTo: moviePoster.bottomAnchor, constant: 25),
            self.contentView.trailingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: 200),
            moviePoster.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            moviePoster.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 25)
        ])
        self.contentView.addSubview(movieTitle)
        NSLayoutConstraint.activate([
            movieTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 30),
            movieTitle.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: 30)
        ])
        //creating small images
        for index in infoImagesArray.indices{
            let smallImage: UIImageView = {
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.contentMode = .scaleAspectFit
                $0.tintColor = .darkGray
                $0.image = UIImage(systemName: infoImagesArray[index])
                return $0
            }(UIImageView())
            self.contentView.addSubview(smallImage)
            NSLayoutConstraint.activate([
                smallImage.topAnchor.constraint(equalTo: movieTitle.bottomAnchor,constant: CGFloat(30 + (index*30))),
                smallImage.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: 30)
            ])
            if index == 2{
                let movieActionButton = ButtonView()
                movieActionButton.layer.cornerRadius = 10
                self.contentView.addSubview(movieActionButton)
                NSLayoutConstraint.activate([
//                    movieActionButton.topAnchor.constraint(equalTo: movieTitle.bottomAnchor,constant: CGFloat(30 + (index*30))),
                    movieActionButton.leadingAnchor.constraint(equalTo: smallImage.trailingAnchor, constant: 5),
                    self.contentView.trailingAnchor.constraint(equalTo: movieActionButton.trailingAnchor, constant: 80),
//                    self.contentView.bottomAnchor.constraint(equalTo: movieActionButton.bottomAnchor, constant: 25)
                    movieActionButton.centerYAnchor.constraint(equalTo: smallImage.centerYAnchor),
                    movieActionButton.heightAnchor.constraint(equalToConstant: 30)
                ])
                movieActionButton.tapCallBack = {
                    print("went to another screen")
                }
            }
            else{
                let infoLabel: UILabel = {
                    $0.translatesAutoresizingMaskIntoConstraints = false
                    $0.text = "info"
                    $0.font = .systemFont(ofSize: 15)
                    return $0
                }(UILabel())
                self.contentView.addSubview(infoLabel)
                NSLayoutConstraint.activate([
                    infoLabel.topAnchor.constraint(equalTo: movieTitle.bottomAnchor,constant: CGFloat(30 + (index*30))),
                    infoLabel.leadingAnchor.constraint(equalTo: smallImage.trailingAnchor, constant: 10)
                ])
            }
        }
    }
}

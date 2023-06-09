//import UIKit
//import Kingfisher
//class MovieTableViewCell: UITableViewCell {
//    let infoImagesArray: [String] = ["stopwatch","calendar","popcorn"]
//    var movieLenght = ""
//    let moviePoster: UIImageView = {
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.contentMode = .scaleAspectFill
//        $0.image = UIImage(systemName: "square")
//        $0.layer.cornerRadius = 20
//        $0.clipsToBounds = true
//        return $0
//    }(UIImageView())
//    let movieTitle: UILabel = {
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.text = "hello"
//        $0.numberOfLines = 2
//        $0.font = .systemFont(ofSize: 15)
//        return $0
//    }(UILabel())
//    let favouriteImageView: UIImageView = {
//        $0.image = UIImage(systemName: "heart")
//        $0.tintColor = .lightGray
//        $0.contentMode = .scaleAspectFill
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        return $0
//    }(UIImageView())
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.translatesAutoresizingMaskIntoConstraints = false
//        setupUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    private func setupUI(){
//        self.contentView.addSubview(moviePoster)
//        NSLayoutConstraint.activate([
//            self.contentView.bottomAnchor.constraint(equalTo: moviePoster.bottomAnchor, constant: 25),
//            self.contentView.trailingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: 200),
//            moviePoster.topAnchor.constraint(equalTo: self.contentView.topAnchor),
//            moviePoster.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 25)
//        ])
//        self.contentView.addSubview(movieTitle)
//        NSLayoutConstraint.activate([
//            movieTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 30),
//            movieTitle.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: 30),
//            movieTitle.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -30)
//        ])
//        self.contentView.addSubview(favouriteImageView)
//        NSLayoutConstraint.activate([
//            favouriteImageView.centerYAnchor.constraint(equalTo: movieTitle.centerYAnchor,constant: -10),
//            favouriteImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
//            favouriteImageView.heightAnchor.constraint(equalToConstant: 35),
//            favouriteImageView.widthAnchor.constraint(equalToConstant: 35)
//        ])
//        //creating small images
//        for index in infoImagesArray.indices{
//            let smallImage: UIImageView = {
//                $0.translatesAutoresizingMaskIntoConstraints = false
//                $0.contentMode = .scaleAspectFit
//                $0.tintColor = .darkGray
//                $0.image = UIImage(systemName: infoImagesArray[index])
//                return $0
//            }(UIImageView())
//            self.contentView.addSubview(smallImage)
//            NSLayoutConstraint.activate([
//                smallImage.topAnchor.constraint(equalTo: movieTitle.bottomAnchor,constant: CGFloat(30 + (index*30))),
//                smallImage.leadingAnchor.constraint(equalTo: moviePoster.trailingAnchor, constant: 30)
//            ])
//            if index == 2{
//                let movieActionButton = ButtonView()
//                movieActionButton.layer.cornerRadius = 10
//                self.contentView.addSubview(movieActionButton)
//                NSLayoutConstraint.activate([
////                    movieActionButton.topAnchor.constraint(equalTo: movieTitle.bottomAnchor,constant: CGFloat(30 + (index*30))),
//                    movieActionButton.leadingAnchor.constraint(equalTo: smallImage.trailingAnchor, constant: 5),
//                    self.contentView.trailingAnchor.constraint(equalTo: movieActionButton.trailingAnchor, constant: 80),
////                    self.contentView.bottomAnchor.constraint(equalTo: movieActionButton.bottomAnchor, constant: 25)
//                    movieActionButton.centerYAnchor.constraint(equalTo: smallImage.centerYAnchor),
//                    movieActionButton.heightAnchor.constraint(equalToConstant: 30)
//                ])
//                movieActionButton.tapCallBack = {
//                    print("went to another screen")
//                }
//                movieActionButton.setTitle("Action", for: .normal)
//            }
//            else{
//                let infoLabel: UILabel = {
//                    $0.translatesAutoresizingMaskIntoConstraints = false
//                    $0.text = self.movieLenght
//                    $0.font = .systemFont(ofSize: 15)
//                    return $0
//                }(UILabel())
//                self.contentView.addSubview(infoLabel)
//                NSLayoutConstraint.activate([
//                    infoLabel.topAnchor.constraint(equalTo: movieTitle.bottomAnchor,constant: CGFloat(30 + (index*30))),
//                    infoLabel.leadingAnchor.constraint(equalTo: smallImage.trailingAnchor, constant: 10)
//                ])
//            }
//        }
//    }
//}

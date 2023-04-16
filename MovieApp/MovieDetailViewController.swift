//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Alexey Davidenko on 07.04.2023.
//

import UIKit

class MovieDetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate {
    
    let firstCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = contentSize
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.frame.size = contentSize
        return contentView
    }()
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 500)
    }
    
    let mainHorStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.distribution = .equalSpacing
        stack.spacing = 20.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let horStack1: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 5.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let horStack2: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 5.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let horStack3: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 5.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let starHorStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 10.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    let movieImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "movieImage")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var movieLabel: UILabel = {
        let label = UILabel()
        label.text = "Luck"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "calendar")
        image.tintColor = .gray
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "17.Sep.2021"
        label.numberOfLines = 1
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var durationImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "clock.fill")
        image.tintColor = .gray
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.text = "148 Minutes"
        label.numberOfLines = 1
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var genreImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "film")
        image.tintColor = .gray
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.text = "Action"
        label.numberOfLines = 1
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var starImage: UIImageView = {
        let image = UIImageView()
            image.image = UIImage(systemName: "star.fill")
            image.tintColor = .gray
            image.translatesAutoresizingMaskIntoConstraints = false
            return image
    }()
    
    lazy var starImage2: UIImageView = {
        let image = UIImageView()
            image.image = UIImage(systemName: "star.fill")
            image.tintColor = .gray
            image.translatesAutoresizingMaskIntoConstraints = false
            return image
    }()
    
    lazy var starImage3: UIImageView = {
        let image = UIImageView()
            image.image = UIImage(systemName: "star.fill")
            image.tintColor = .gray
            image.translatesAutoresizingMaskIntoConstraints = false
            return image
    }()
    
    lazy var starImage4: UIImageView = {
        let image = UIImageView()
            image.image = UIImage(systemName: "star.fill")
            image.tintColor = .gray
            image.translatesAutoresizingMaskIntoConstraints = false
            return image
    }()
    
    lazy var starImage5: UIImageView = {
        let image = UIImageView()
            image.image = UIImage(systemName: "star.fill")
            image.tintColor = .gray
            image.translatesAutoresizingMaskIntoConstraints = false
            return image
    }()
    
    private lazy var storyLineLabel: UILabel = {
        let label = UILabel()
        label.text = "Story line"
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var filmDetailText: UILabel = {
        let label = UILabel()
        label.text = "Text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text text"
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16, weight: .thin)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var castAndCrewLabel: UILabel = {
        let label = UILabel()
        label.text = "Cast and Crew"
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var watchNowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Watch Now", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        
        navigationItem.hidesSearchBarWhenScrolling = false
        
        firstCollectionView.dataSource = self
        firstCollectionView.delegate = self
        firstCollectionView.showsHorizontalScrollIndicator = false
        firstCollectionView.register(CrewCustomCell.self, forCellWithReuseIdentifier: "CrewCustomCell")
        
        view.backgroundColor = .white
        
        setupHierarchy()
        setLayout()
        setConstrains()
    }
    
    func setLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        firstCollectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CrewCustomCell", for: indexPath) as! CrewCustomCell
        return cell
    }
    
    @objc func buttonTapped(_ sender: UIButton) {

    }
    
    //MARK: - setupHierarchy
    
    func setupHierarchy() {

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(movieImage)
        contentView.addSubview(movieLabel)
        contentView.addSubview(mainHorStack)
        mainHorStack.addArrangedSubview(horStack1)
        horStack1.addArrangedSubview(dateImage)
        horStack1.addArrangedSubview(dateLabel)
        mainHorStack.addArrangedSubview(horStack2)
        horStack2.addArrangedSubview(durationImage)
        horStack2.addArrangedSubview(durationLabel)
        mainHorStack.addArrangedSubview(horStack3)
        horStack3.addArrangedSubview(genreImage)
        horStack3.addArrangedSubview(genreLabel)
        contentView.addSubview(starHorStack)
        starHorStack.addArrangedSubview(starImage)
        starHorStack.addArrangedSubview(starImage2)
        starHorStack.addArrangedSubview(starImage3)
        starHorStack.addArrangedSubview(starImage4)
        starHorStack.addArrangedSubview(starImage5)
        contentView.addSubview(storyLineLabel)
        contentView.addSubview(filmDetailText)
        //contentView.addSubview(castAndCrewLabel)
      //  contentView.addSubview(firstCollectionView)
        contentView.addSubview(watchNowButton)
    }
    
    //MARK: - Constrains
    
    func setConstrains() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            movieImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            movieImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            movieImage.heightAnchor.constraint(equalToConstant: 300),
            movieImage.widthAnchor.constraint(equalToConstant: 224),

            movieLabel.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 24),
            movieLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            mainHorStack.topAnchor.constraint(equalTo: movieLabel.bottomAnchor, constant: 24),
            mainHorStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            starHorStack.topAnchor.constraint(equalTo: mainHorStack.bottomAnchor, constant: 24),
            starHorStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            storyLineLabel.topAnchor.constraint(equalTo: starHorStack.bottomAnchor, constant: 24),
            storyLineLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 24),

            filmDetailText.topAnchor.constraint(equalTo: storyLineLabel.bottomAnchor, constant: 24),
            filmDetailText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            filmDetailText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),

//            castAndCrewLabel.topAnchor.constraint(equalTo: filmDetailText.bottomAnchor, constant: 24),
//            castAndCrewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),

//            firstCollectionView.topAnchor.constraint(equalTo: castAndCrewLabel.bottomAnchor, constant: 24),
//            firstCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            firstCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            firstCollectionView.heightAnchor.constraint(equalToConstant: 60),

            watchNowButton.topAnchor.constraint(equalTo: filmDetailText.bottomAnchor, constant: 24),
            watchNowButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            watchNowButton.heightAnchor.constraint(equalToConstant: 56),
            watchNowButton.widthAnchor.constraint(equalToConstant: 181),
                      
        ])
    }
}

//MARK: - Extension
extension MovieDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: UIScreen.main.bounds.width * 0.75, height: UIScreen.main.bounds.width * 0.83)
    }
}


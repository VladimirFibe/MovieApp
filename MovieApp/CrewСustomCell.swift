//
//  FirstCustomCell.swift
//  MovieApp
//
//  Created by Alexey Davidenko on 12.04.2023.
//

import UIKit

class CrewCustomCell: UICollectionViewCell {
    
    var data: CustomData? {
        didSet {
            guard let data = data else { return }
            image.image = data.memberImage
        }
    }
    
    fileprivate let image: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "avatarImage")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 16
        return iv
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "John Watts"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var jobTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Director"
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupHierarchy()
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupHierarchy() {
        
        contentView.addSubview(image)
        contentView.addSubview(nameLabel)
        contentView.addSubview(jobTitleLabel)
    }
    
    func setConstrains() {
        
        NSLayoutConstraint.activate([
            
            contentView.heightAnchor.constraint(equalToConstant: 60),
            
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.heightAnchor.constraint(equalToConstant: 40),
            image.widthAnchor.constraint(equalToConstant: 40),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
            nameLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 3),
            
            jobTitleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
            jobTitleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 3),
                      
        ])
    }
}



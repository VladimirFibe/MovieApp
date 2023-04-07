//
//  UserImageCell.swift
//  MovieApp
//
//  Created by Павел Грицков on 05.04.23.
//

import UIKit

class UserImageCell: UITableViewCell {
    
    private let imageSize: CGFloat = 100.0
    
    private let contViewForImage = UIView()

    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.backgroundColor = .lightGray
        imageView.tintColor = .orange
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubview(contViewForImage)
        contViewForImage.addSubview(userImageView)
        contViewForImage.layer.cornerRadius = imageSize / 2
        contViewForImage.clipsToBounds = true
    }
    
    func configureCell(image imageName: String) {
        // userImage
        userImageView.image = UIImage(named: imageName)
        setConstraints()
    }
    
    func setConstraints() {
        contViewForImage.translatesAutoresizingMaskIntoConstraints = false
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contViewForImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            contViewForImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            contViewForImage.heightAnchor.constraint(equalToConstant: 100),
            contViewForImage.widthAnchor.constraint(equalTo: contViewForImage.heightAnchor),
            
            userImageView.centerXAnchor.constraint(equalTo: contViewForImage.centerXAnchor),
            userImageView.centerYAnchor.constraint(equalTo: contViewForImage.centerYAnchor),
            userImageView.widthAnchor.constraint(equalTo: contViewForImage.widthAnchor),
            userImageView.heightAnchor.constraint(equalTo: contViewForImage.heightAnchor),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

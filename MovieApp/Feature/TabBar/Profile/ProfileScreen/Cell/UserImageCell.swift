//
//  UserImageCell.swift
//  MovieApp
//
//  Created by Павел Грицков on 05.04.23.
//

import UIKit

protocol UserImageCellDelegate: AnyObject {
    /// cell - ячека в которой сработал делегат.
    /// imageView - аватар пользователя
    func cellEditImageViewDidPress(cell: UserImageCell, imageView: UIImageView)
}

class UserImageCell: UITableViewCell {
    
    weak var delegate: UserImageCellDelegate?
    
    private let imageSize: CGFloat = 100.0
    private let whiteCircleSize: CGFloat = 32.0
    
    private let contViewForImage = UIView()

    lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.tintColor = .lightGray
        imageView.layer.cornerRadius = imageSize / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let editImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Edit")
        imageView.isUserInteractionEnabled = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubview(contViewForImage)
        contViewForImage.addSubview(userImageView)
        contViewForImage.addSubview(editImageView)
        
        contentView.backgroundColor = Theme.whiteToBlack
        
        editImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(editImagePressed))
        editImageView.addGestureRecognizer(tapGesture)
    }
    
    func configureCell(image imageName: String) {
        userImageView.image = UIImage(named: imageName)
        setConstraints()
    }
    
    @objc func editImagePressed(_ sender: UIImageView) {
        delegate?.cellEditImageViewDidPress(cell: self, imageView: userImageView)
    }
    
    private func setConstraints() {
        
        [contViewForImage, userImageView ,editImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            contViewForImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            contViewForImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            contViewForImage.heightAnchor.constraint(equalToConstant: 100),
            contViewForImage.widthAnchor.constraint(equalTo: contViewForImage.heightAnchor),
            
            userImageView.centerXAnchor.constraint(equalTo: contViewForImage.centerXAnchor),
            userImageView.centerYAnchor.constraint(equalTo: contViewForImage.centerYAnchor),
            userImageView.widthAnchor.constraint(equalTo: contViewForImage.widthAnchor),
            userImageView.heightAnchor.constraint(equalTo: contViewForImage.heightAnchor),
            
            editImageView.heightAnchor.constraint(equalToConstant: whiteCircleSize),
            editImageView.widthAnchor.constraint(equalToConstant: whiteCircleSize),
            editImageView.trailingAnchor.constraint(equalTo: contViewForImage.trailingAnchor),
            editImageView.bottomAnchor.constraint(equalTo: contViewForImage.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

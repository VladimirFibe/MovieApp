//
//  DescriptionContainer.swift
//  MovieApp
//
//  Created by Павел Грицков on 12.04.23.
//

import UIKit

class DescriptionContainerView: UIView {
    
    enum ContentStyle {
        case lable
        case button
    }
    
    // MARK: - Constants
    private let height: CGFloat = 28.0
    private let width: CGFloat = 200.0
    private let offSetVer: CGFloat = 12.0
     
    // MARK: - Content Views
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Theme.darkGreyToWhite
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = Theme.darkGreyToWhite
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Action", for: .normal)
        button.backgroundColor = Theme.purple
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()

    
    init() {
        super.init(frame: .zero)
        
        configureUI()
        setConstraints()
    }
    
    func configure(text: String, image: UIImage?, style: ContentStyle) {
        
        imageView.image = image ?? UIImage(systemName: "staroflife.fill")
        
        switch style {
        case .lable:
            label.text = text
            addSubview(label)
            setConstraintsLabel()
        case .button:
            addSubview(button)
            setConstraintsButton()
        }
    }
    
    private func configureUI() {
        addSubview(imageView)
    }
    
    // MARK: - Set Constraints
    private func setConstraints() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let heightConst = NSLayoutConstraint(
            item: self,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .height,
            multiplier: 1,
            constant: height)
        heightConst.priority = .defaultHigh
        heightConst.isActive = true
        
        let widthConst = NSLayoutConstraint(
            item: self,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .width,
            multiplier: 1,
            constant: width)
        widthConst.priority = .defaultLow
        widthConst.isActive = true
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 22),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: offSetVer)
        ])
    }
    
    private func setConstraintsLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: offSetVer),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -offSetVer),
            label.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    private func setConstraintsButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: centerYAnchor),
            button.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: offSetVer),
            button.widthAnchor.constraint(equalToConstant: 65.0),
            button.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

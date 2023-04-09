//
//  GenderViewCell.swift
//  MovieApp
//
//  Created by Павел Грицков on 05.04.23.
//

import UIKit

class GenderCell: UITableViewCell {
    
    enum Gender {
        case male
        case female
        case notSelected
    }

    private let offset: CGFloat = 20

    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        return stackView
    }()
    
    let maleButtonView = MainButton(type: .system)
    let femaleButtonView = MainButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubview(title)
        contentView.addSubview(stackView)
        configureUI()
    }
    
    func configure(title text: String, textFildPlaceholder placeholder: String, gender: Gender) {
        setConstraints()
        title.text = text
        
        switch gender {
        case .male:
            maleButtonView.setButton(style: .borderAndImage, title: "Male", isActive: true)
        case .female:
            femaleButtonView.setButton(style: .borderAndImage, title: "Female", isActive: true)
        case .notSelected:
            maleButtonView.setButton(style: .borderAndImage, title: "Male", isActive: false)
            femaleButtonView.setButton(style: .borderAndImage, title: "Female", isActive: false)
        }
        
        maleButtonView.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        femaleButtonView.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    private func configureUI() {
        stackView.spacing = offset
        
        stackView.addArrangedSubview(maleButtonView)
        stackView.addArrangedSubview(femaleButtonView)
    }
    
    func setConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: offset),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -offset),
            title.bottomAnchor.constraint(equalTo: stackView.topAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: offset),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -offset),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        if let title = sender.currentTitle {
            print(title)
        }
    }
}

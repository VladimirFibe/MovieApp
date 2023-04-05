//
//  FormViewCell.swift
//  MovieApp
//
//  Created by Павел Грицков on 05.04.23.
//

import UIKit

class FormViewCell: UITableViewCell {
    
    private let offset: CGFloat = 20

    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    let textFieldView = TextFieldView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        contentView.addSubview(title)
        contentView.addSubview(textFieldView)
    }
    
    func configure(title text: String, textFildPlaceholder placeholder: String) {
        setConstraints()
        title.text = text
        textFieldView.configure(style: .border, textFildPlaceholder: placeholder)
    }
    
    func setConstraints() {
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: offset),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -offset),
            title.bottomAnchor.constraint(equalTo: textFieldView.topAnchor),
            
            textFieldView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: offset),
            textFieldView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -offset),
            textFieldView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

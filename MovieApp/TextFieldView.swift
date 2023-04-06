//
//  TextFieldView.swift
//  MovieApp
//
//  Created by Павел Грицков on 04.04.23.
//

import UIKit

class TextFieldView: UIView {
    
    private let height: CGFloat = 56.0
    private var width: CGFloat = 300
    
    let textField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    private func configureUI() {
        layer.cornerRadius = height / 2
//        layer.borderColor = UIColor.black.cgColor
//        layer.borderWidth = 2
        backgroundColor = .lightGray
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        setConstraints()
    }
    
    func configure(placeholder text: String) {
        configureUI()
        textField.placeholder = text
    }
    
    private func setConstraints() {
        let widthConstraint = NSLayoutConstraint(
            item: self,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .width,
            multiplier: 1.0,
            constant: width)
        widthConstraint.priority = .defaultLow

        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: height),
            widthConstraint,
            
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.heightAnchor.constraint(equalTo: heightAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20)
        ])
    }
}

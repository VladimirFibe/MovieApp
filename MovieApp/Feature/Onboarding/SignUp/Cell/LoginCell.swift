//
//  LoginCell.swift
//  MovieApp
//
//  Created by Павел Грицков on 14.04.23.
//

import UIKit

class LoginCell: UITableViewCell {
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = Theme.whiteToBlack
        contentView.addSubview(loginButton)
        setAttributeForButton()
        setConstraints()
        
        loginButton.addTarget(self, action: #selector(logitButtonPressed), for: .touchUpInside)
    }
    
    @objc func logitButtonPressed() {
        print(#function)
    }
    
    func setAttributeForButton() {
        let attributedString = NSMutableAttributedString(string: "Already have an account? Login")
        attributedString.addAttributes([.foregroundColor : Theme.darkGreyToWhite,
                                        .font : UIFont.boldSystemFont(ofSize: 16)],
                                       range: NSRange(location: 0, length: 24))
        attributedString.addAttributes([.foregroundColor : Theme.purple,
                                        .font : UIFont.boldSystemFont(ofSize: 16)],
                                       range: NSRange(location: 25, length: 5))
        loginButton.setAttributedTitle(attributedString, for: .normal)

    }
    
    func setConstraints() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.heightAnchor.constraint(equalToConstant: 24),
            loginButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

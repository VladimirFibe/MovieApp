//
//  CreateAccountViewController.swift
//  MovieApp
//
//  Created by Павел Грицков on 04.04.23.
//

import UIKit

class CreateAccountViewController: UIViewController {
    
    let buttons: [MainButton] = [.init(), .init(), .init()]
    
    let screenNameLabel: UILabel = {
       let label = UILabel()
        label.text = "Create Account"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let screenDescriptionLabel: UILabel = {
        let label = UILabel()
         label.text = "You can create account here"
         label.font = UIFont.boldSystemFont(ofSize: 16)
         label.textColor = .white
         label.textAlignment = .center
         return label
     }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    lazy var backView: UIView = {
        let view = UIView()
        view.frame = self.view.frame
        view.frame.size.height = self.view.frame.height * 0.8
        view.frame.origin.y = self.view.frame.height * 0.25
        view.layer.cornerRadius = 30
        view.backgroundColor = .white
        return view
    }()
    
// MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setConstraints()
    }
    
    
// MARK: - Start setup
    func configureUI() {
        view.backgroundColor = UIColor(named: "mainBlue")
        view.addSubview(backView)
        
//        view.addSubview(emailButton)
//        emailButton.setButton(style: .withoutFill, andTitle: "Continue with email")
        
        [screenNameLabel, screenDescriptionLabel, stackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    func configureStackView() {
        [UIView()].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    
// MARK: - Set Constraints
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            screenNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            screenNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            screenNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            screenNameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            screenDescriptionLabel.topAnchor.constraint(equalTo: screenNameLabel.bottomAnchor, constant: 4),
            screenDescriptionLabel.leadingAnchor.constraint(equalTo: screenNameLabel.leadingAnchor),
            screenDescriptionLabel.trailingAnchor.constraint(equalTo: screenNameLabel.trailingAnchor),
            screenDescriptionLabel.heightAnchor.constraint(equalToConstant: 16),
            
//            emailButton.topAnchor.constraint(equalTo: backView.topAnchor),
//            emailButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            emailButton.widthAnchor.constraint(equalToConstant: 300),
        ])
    }
}

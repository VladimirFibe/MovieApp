//
//  ViewController.swift
//  MovieApp
//
//  Created by Vladimir on 03.04.2023.
//

import UIKit

class ViewController: UIViewController {
    let registerTableView = UITableView()
    let backButton = BackButtonView()
    let signUpButton: ButtonView = {
        $0.labelText.text = "Sign Up"
        return $0
    }(ButtonView())
    let labelSign: UILabel = {
        $0.text = "Sign up"
        $0.font = .systemFont(ofSize: 24)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    let labelInfo: UILabel = {
        $0.text = "Complete Your Account"
        $0.font = .systemFont(ofSize: 28)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }
}
extension ViewController{
    func setupConstraints(){
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        ])
        view.addSubview(labelSign)
        NSLayoutConstraint.activate([
            labelSign.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            labelSign.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        view.addSubview(labelInfo)
        NSLayoutConstraint.activate([
            labelInfo.topAnchor.constraint(equalTo: labelSign.bottomAnchor,constant: 50),
            labelInfo.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        view.addSubview(registerTableView)
        NSLayoutConstraint.activate([
            
        ])
        view.addSubview(signUpButton)
        NSLayoutConstraint.activate([
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            view.trailingAnchor.constraint(equalTo: signUpButton.trailingAnchor, constant: 30),
            view.bottomAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 100),
            signUpButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


//
//  ViewController.swift
//  MovieApp
//
//  Created by Vladimir on 03.04.2023.
//

import UIKit

class ViewController: UIViewController {
    let registerView = UITableView()
    let backButton = BackButtonView()
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
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45)
        ])
    }
}


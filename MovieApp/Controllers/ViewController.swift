//
//  ViewController.swift
//  MovieApp
//
//  Created by Vladimir on 03.04.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    let labelInfoArray = ["First Name", "Last Name","E-mail","Password","Confirm Password"]
    let registerTableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView())
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
        registerTableView.delegate = self
        registerTableView.dataSource = self
        registerTableView.register(RegisterTableViewCell.self, forCellReuseIdentifier: "cell")
        registerTableView.separatorStyle = .none
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = registerTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RegisterTableViewCell
        let labelInfo = labelInfoArray[indexPath.row]
        cell = RegisterTableViewCell( "Enter you \(labelInfo)",labelInfo)
        switch labelInfo{
        case "Password","Confirm Password":
            cell.hidePasswordButton.isHidden = false
        default:
            cell.hidePasswordButton.isHidden = true
        }
        return cell
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
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
        view.addSubview(signUpButton)
        NSLayoutConstraint.activate([
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            view.trailingAnchor.constraint(equalTo: signUpButton.trailingAnchor, constant: 30),
            view.bottomAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 100),
            signUpButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        view.addSubview(registerTableView)
        NSLayoutConstraint.activate([
            registerTableView.topAnchor.constraint(equalTo: labelInfo.bottomAnchor, constant: 40),
            registerTableView.bottomAnchor.constraint(equalTo: signUpButton.topAnchor,constant: -40),
            registerTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            view.trailingAnchor.constraint(equalTo: registerTableView.trailingAnchor, constant: 30)
        ])
    }
}


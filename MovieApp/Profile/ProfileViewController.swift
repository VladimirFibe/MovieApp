//
//  ProfileViewController.swift
//  MovieApp
//
//  Created by Павел Грицков on 04.04.23.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setConstraints()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        title = "Profile"
    }
    
    // MARK: - UI methods
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .none
//        tableView.alwaysBounceVertical = false
//        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(UserImageCell.self, forCellReuseIdentifier: String(describing: UserImageCell.self))
        tableView.register(FormViewCell.self, forCellReuseIdentifier: String(describing: FormViewCell.self))
        tableView.register(GenderViewCell.self, forCellReuseIdentifier: String(describing: GenderViewCell.self))
    }
    
    // MARK: - Set constraints
    func setConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

// MARK: - Table Data Source
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = UserImageCell(style: .default, reuseIdentifier: String(describing: UserImageCell.self))
            cell.configureCell(image: "userImage")
            return cell
        case 1: return createCellForm(title: "First Name", placeholder: "enter your name")
        case 2: return createCellForm(title: "Last Name", placeholder: "enter your name")
        case 3: return createCellForm(title: "E-mail", placeholder: "enter your e-mail")
        case 4: return createCellForm(title: "Date of Birth", placeholder: "enter your date of dirth")
        case 5:
            let cell = GenderViewCell(style: .default, reuseIdentifier: String(describing: GenderViewCell.self))
            cell.configure(title: "Gender", textFildPlaceholder: "")
            return cell
        default: return UITableViewCell()
        }
    }
    
    private func createCellForm(title: String, placeholder: String) -> FormViewCell {
        let cell = FormViewCell(style: .default, reuseIdentifier: String(describing: FormViewCell.self))
        cell.configure(title: title, textFildPlaceholder: placeholder)
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return 150
        case 1,2,3,4: return 97
        case 5: return 100
        default: return 300
        }
    }
}


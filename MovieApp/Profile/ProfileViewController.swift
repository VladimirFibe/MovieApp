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
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        
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
        7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = UserImageCell()
            cell.configureCell(image: "userImage")
            return cell
        case 1: return createCellWith(title: "First Name", placeholder: "enter your name")
        case 2: return createCellWith(title: "Last Name", placeholder: "enter your name")
        case 3: return createCellWith(title: "E-mail", placeholder: "enter your e-mail")
        case 4:
            let cell = createCellWith(title: "Date of Birth", placeholder: "enter your date of dirth")
            cell.delegate = self
            cell.activateDatePickerForTextField()
            return cell
        case 5:
            let cell = GenderViewCell()
            cell.configure(title: "Gender", textFildPlaceholder: "")
            return cell
        case 6:
            let cell = SaveChangesCell()
            return cell
        default: return UITableViewCell()
        }
    }
    
    private func createCellWith(title: String, placeholder: String) -> FormViewCell {
        let cell = FormViewCell()
        cell.configure(title: title, textFildPlaceholder: placeholder)
        cell.delegate = self
        return cell
    }
}

// MARK: - TableView Delegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return 150
        default: return 97
        }
    }
}

// MARK: - FormViewCellDelegate
extension ProfileViewController: FormViewCellDelegate {
    func cellTextFieldDidEndEditing(cell: FormViewCell, textField: UITextField, text: String) {
        print(#function, text)
    }
}


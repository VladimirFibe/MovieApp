//
//  SignUpViewController.swift
//  MovieApp
//
//  Created by Павел Грицков on 14.04.23.
//

import UIKit

class SignUpViewController: BaseViewController {
    
    enum SignUpK {
        enum Title {
            static let signUp = "Sign Up"
            static let firstName = "First Name"
            static let lastName = "Last Name"
            static let email = "E-mail"
            static let password = "Password"
            static let ConfirmPassword = "Confirm Password"
        }
        enum Placeholder {
            static let firstName = "Enter your first name"
            static let lastName = "Enter your last name"
            static let email = "Enter your email"
            static let password = "Enter your password"
            static let confirmPassword = "Enter your password"
        }
    }
    
    let tableView = UITableView(frame: .zero, style: .plain)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setConstraints()
    }
    
    // MARK: - UI methods
    func configureUI() {
        navigationItem.title = "Sign Up"
        view.backgroundColor = Theme.whiteToBlack
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .none
//        tableView.isScrollEnabled = false
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
extension SignUpViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = HeaderCell()
            return cell
        case 1:
            return createCellWith(title: SignUpK.Title.firstName, placeholder: SignUpK.Placeholder.firstName)
        case 2:
            return createCellWith(title: SignUpK.Title.lastName, placeholder: SignUpK.Placeholder.lastName)
        case 3:
            return createCellWith(title: SignUpK.Title.email, placeholder: SignUpK.Placeholder.email)
        case 4:
            let cell = createCellWith(title: SignUpK.Title.password, placeholder: SignUpK.Placeholder.password)
            cell.secureModeOn()
            return cell
        case 5:
            let cell = createCellWith(title: SignUpK.Title.ConfirmPassword, placeholder: SignUpK.Placeholder.confirmPassword)
            cell.secureModeOn()
            return cell
        case 6:
            let cell = ButtonActionCell()
            cell.configure(buttonTitle: SignUpK.Title.signUp)
            cell.delegate = self
            return cell
        case 7: let cell = LoginCell()
            cell.delegate = self
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    private func createCellWith(title: String, placeholder: String) -> FormCell {
        let cell = FormCell()
        cell.configure(title: title, textFildPlaceholder: placeholder, style: .fill)
        cell.delegate = self
        return cell
    }
}

extension SignUpViewController: FormCellDelegate {
    func cellTextFieldDidEndEditing(cell: FormCell, textField: UITextField, text: String) {
        // TODO: данные ввыедунные пользователем
        print(text)
    }
    
    func cellTextFieldShouldBeginEditing(cell: FormCell, textField: UITextField) {
        // реализовать смещения UI когда поднимается клавиатура
    }
}

// MARK: - TableView Delegate
extension SignUpViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return 100
        case 7: return 35
        default: return 97
        }
    }
}

// MARK: - Login Cell Delegate
extension SignUpViewController: LoginCellDelegate {
    func cellLoginButtonDidPress(cell: LoginCell, button: UIButton) {
        print(#function)
        // TODO: Уже есть аккаунт
    }
}

// MARK: - Button Action Cell Delegate
extension SignUpViewController: ButtonActionCellDelegate {
    func cellButtonPressed(cell: ButtonActionCell, button: UIButton) {
        print(#function)
        // TODO: Sign Up
    }
}

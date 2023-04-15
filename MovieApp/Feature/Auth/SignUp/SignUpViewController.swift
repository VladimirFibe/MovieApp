//
//  SignUpViewController.swift
//  MovieApp
//
//  Created by Павел Грицков on 14.04.23.
//

import UIKit

struct SignUpNavigation {
    let login: Callback
}

class SignUpViewController: BaseViewController {
    private let store = SignUpStore()
    private var bag = Bag()
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
    private let navigation: SignUpNavigation
    
    init(navigation: SignUpNavigation) {
        self.navigation = navigation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    private var indexPathSelectedCell: IndexPath?
    let notification = NotificationCenter.default

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setConstraints()
        changeInterfaceWhenShowKeyboard()
        setupObservers()
    }
    
    private func setupObservers() {
        store
            .events
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .login:
                    self.navigation.login()
                }
            }.store(in: &bag)
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
        // устанавливает indexPath текущей редактируемой ячейки
        let indexPath = self.tableView.indexPath(for: cell)
        indexPathSelectedCell = indexPath
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
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Button Action Cell Delegate
extension SignUpViewController: ButtonActionCellDelegate {
    func cellButtonPressed(cell: ButtonActionCell, button: UIButton) {
        store.actions.send(.createUser(email: "mail4@mail.ru",
                                       password: "123456",
                                       firstname: "Ivan",
                                       lastname: "Ivanov"))
    }
}

// MARK: - NotificationCenter show or hide keyboard
extension SignUpViewController {
    func changeInterfaceWhenShowKeyboard() {
        
        notification.addObserver(
            forName: UIResponder.keyboardWillShowNotification,
            object: nil, queue: nil) { [weak self] notification in
                
                guard let self = self else { return }
                
                guard let userInfo = notification.userInfo else { return }
                
                guard let screen = notification.object as? UIScreen,
                    let keyboardFrameEnd =
                        userInfo[UIResponder.keyboardFrameEndUserInfoKey]
                        as? CGRect else { return }
                
                // отступы safeArea
//                let bottomOffset = self.view.safeAreaInsets.bottom
                let topOffset = self.view.safeAreaInsets.top
                
                // вычисление корректного фрайка клавиатуры (по гайду от apple)
                let fromCoordinateSpace = screen.coordinateSpace
                let toCoordinateSpace: UICoordinateSpace = self.view

                let convertedKeyboardFrameEnd = fromCoordinateSpace.convert(keyboardFrameEnd, to: toCoordinateSpace)
     
                guard let indexPath = self.indexPathSelectedCell else { return }
                guard let cell = self.tableView.cellForRow(at: indexPath) else { return }
                
                // вычисления отступа на который нужно поднять контент
                let cellMaxY = cell.frame.maxY
                let viewH = self.view.frame.height
                let keyH = convertedKeyboardFrameEnd.height
                let cellOffset = (cellMaxY + topOffset) - (viewH - keyH)
                
                if cellOffset > 0 {
                    self.tableView.contentOffset = CGPoint(x: 0, y: cellOffset)
                }
            }

        notification.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil, queue: nil) { [weak self] _ in
                guard let self = self else { return }
                self.tableView.contentOffset = CGPoint(x: 0, y: 0)
            }
    }
}


import UIKit

class ProfileViewController: BaseViewController {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    let notification = NotificationCenter.default
    
    var tableViewBottomConstraint: NSLayoutConstraint!
    
    private var indexPathSelectedCell: IndexPath?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setConstraints()
        changeInterfaceWhenShowKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        title = "Profile"
    }
    
    // MARK: - UI methods
    func configureUI() {
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
        
       tableViewBottomConstraint = NSLayoutConstraint(
            item: tableView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: view.safeAreaLayoutGuide,
            attribute: .bottom,
            multiplier: 1.0, constant: 0)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableViewBottomConstraint,
        ])
    }
    
    deinit {
        notification.removeObserver(self)
        print(#function)
        print("deinit")
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
            cell.delegate = self
            cell.configureCell(image: "ava")
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
            let cell = GenderCell()
            cell.configure(title: "Gender", textFildPlaceholder: "", gender: .notSelected)
            return cell
        case 6:
            let cell = ButtonActionCell()
            cell.configure(buttonTitle: "Save Changes")
            cell.delegate = self
            return cell
        default: return UITableViewCell()
        }
    }
    
    private func createCellWith(title: String, placeholder: String) -> FormCell {
        let cell = FormCell()
        cell.configure(title: title, textFildPlaceholder: placeholder, style: .border)
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
extension ProfileViewController: FormCellDelegate {
    func cellTextFieldShouldBeginEditing(cell: FormCell, textField: UITextField) {
        
        // устанавливает indexPath текущей редактируемой ячейки
        let indexPath = self.tableView.indexPath(for: cell)
        indexPathSelectedCell = indexPath
    }
    
    func cellTextFieldDidEndEditing(cell: FormCell, textField: UITextField, text: String) {
        // TODO: данные ввыедунные пользователем
        print(text)
    }
}

// MARK: - SaveChangesCellDelegate
extension ProfileViewController: ButtonActionCellDelegate {
    func cellButtonPressed(cell: ButtonActionCell, button: UIButton) {
        print("save button pressed")
    }
}

// MARK: - UserImage Cell Delegate
extension ProfileViewController: UserImageCellDelegate {
    func cellEditImageViewDidPress(cell: UserImageCell, imageView: UIImageView) {
        print(#function)
        let vc = PopUpViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

// MARK: - NotificationCenter show or hide keyboard
extension ProfileViewController {
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


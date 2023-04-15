import UIKit

struct SettingsNavigation {
    let profileTapped: Callback
    let logoutTapped: Callback
}

class SettingsViewController: BaseViewController {
    private let store = SettingsStore()
    private var bag = Bag()
    
    private let navigation: SettingsNavigation
    init(navigation: SettingsNavigation) {
        self.navigation = navigation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let verStack: UIStackView = {
        let subStack = UIStackView()
        subStack.axis = .vertical
        subStack.alignment = .leading
        subStack.distribution = .equalSpacing
        subStack.spacing = 10.0
        subStack.translatesAutoresizingMaskIntoConstraints = false
        return subStack
    }()

    let avatarImage: UIImageView = {
        let avatar = UIImageView()
        avatar.image = UIImage(named: "avatarImage")
        avatar.contentMode = .scaleAspectFit
        avatar.clipsToBounds = true
        avatar.translatesAutoresizingMaskIntoConstraints = false
        return avatar
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name Surname"
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var telegramLabel: UILabel = {
        let label = UILabel()
        label.text = "@userID"
        label.numberOfLines = 1
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var personalInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Personal Info"
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var securityLabel: UILabel = {
        let label = UILabel()
        label.text = "Security"
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "person"), for: .normal)
        button.setTitle("  Profile", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        button.contentHorizontalAlignment = .left
        //button.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.right")
        image.tintColor = .gray
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var changePasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "lock"), for: .normal)
        button.setTitle("  Change Password", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        button.contentHorizontalAlignment = .left
        button.tintColor = .black
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "lock.open"), for: .normal)
        button.setTitle(" Forgot Password", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        button.contentHorizontalAlignment = .left
        button.tintColor = .black
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var darkModeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "moon")
        image.tintColor = .black
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var darkModeLabel: UILabel = {
        let label = UILabel()
        label.text = "   Dark Mode"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var darkModeSwitcher: UISwitch = {
        let switcher = UISwitch()
        switcher.translatesAutoresizingMaskIntoConstraints = false
        return switcher
    }()
    
    lazy var logOutButton: UIButton = {
        let myHexColor = UIColor(hex: "#514EB6")
        let button = UIButton(type: .system)
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .black
        button.backgroundColor = .clear
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        
        setupHierarchy()
        setConstrains()
        setupObservers()
        view.backgroundColor = .white
        title = ""
        tabBarItem.title = "Settings"
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont.boldSystemFont(ofSize: 24)
        ]
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        self.navigation.profileTapped()
    }
    
    @objc func logoutTapped(_ sender: UIButton) {
        store.actions.send(.logout)
    }
    
    private func setupObservers() {
        store
            .events
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .didLogout:
                    self.navigation.logoutTapped()
                }
            }.store(in: &bag)
    }
    
    func setupHierarchy() {
        
        view.addSubview(avatarImage)
        view.addSubview(verStack)
        verStack.addArrangedSubview(nameLabel)
        verStack.addArrangedSubview(telegramLabel)
        view.addSubview(personalInfoLabel)
        view.addSubview(profileButton)
        view.addSubview(profileImage)
        view.addSubview(securityLabel)
        view.addSubview(changePasswordButton)
        view.addSubview(forgotPasswordButton)
        view.addSubview(darkModeImage)
        view.addSubview(darkModeLabel)
        view.addSubview(darkModeSwitcher)
        view.addSubview(logOutButton)

    }
    
    func setConstrains() {
        
        NSLayoutConstraint.activate([
            
            avatarImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            avatarImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            avatarImage.heightAnchor.constraint(equalToConstant: 80),
            avatarImage.widthAnchor.constraint(equalToConstant: 80),
            
            verStack.topAnchor.constraint(equalTo: avatarImage.topAnchor, constant: 10),
            verStack.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 24),
            
            personalInfoLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 32),
            personalInfoLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            
            profileButton.topAnchor.constraint(equalTo: personalInfoLabel.bottomAnchor, constant: 24),
            profileButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            profileButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            profileButton.heightAnchor.constraint(equalToConstant: 30),
            
            profileImage.topAnchor.constraint(equalTo: personalInfoLabel.bottomAnchor, constant: 24),
            profileImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            securityLabel.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 32),
            securityLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            
            changePasswordButton.topAnchor.constraint(equalTo: securityLabel.bottomAnchor, constant: 24),
            changePasswordButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            changePasswordButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            changePasswordButton.heightAnchor.constraint(equalToConstant: 30),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: changePasswordButton.bottomAnchor, constant: 24),
            forgotPasswordButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 30),
            
            darkModeImage.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 24),
            darkModeImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            
            darkModeLabel.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 24),
            darkModeLabel.leadingAnchor.constraint(equalTo: darkModeImage.trailingAnchor),
            
            darkModeSwitcher.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 24),
            darkModeSwitcher.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            logOutButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            logOutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            logOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -17),
            logOutButton.heightAnchor.constraint(equalToConstant: 60),
            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }
}


extension UIButton {
   func selectedButton(title:String, iconName: String, widthConstraints: NSLayoutConstraint){
   self.backgroundColor = UIColor(red: 0, green: 118/255, blue: 254/255, alpha: 1)
   self.setTitle(title, for: .normal)
   self.setTitle(title, for: .highlighted)
   self.setTitleColor(UIColor.white, for: .normal)
   self.setTitleColor(UIColor.white, for: .highlighted)
   self.setImage(UIImage(named: iconName), for: .normal)
   self.setImage(UIImage(named: iconName), for: .highlighted)
   let imageWidth = self.imageView!.frame.width
   let textWidth = (title as NSString).size(withAttributes:[NSAttributedString.Key.font:self.titleLabel!.font!]).width
   let width = textWidth + imageWidth + 24
   //24 - the sum of your insets from left and right
   widthConstraints.constant = width
   self.layoutIfNeeded()
   }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        return nil
    }
}

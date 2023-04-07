//
//  CreateAccountViewController.swift
//  MovieApp
//
//  Created by Павел Грицков on 04.04.23.
//

import UIKit

struct CreateAccountNavigation {
    let finish: Callback
}
class CreateAccountViewController: ViewController {
    let navigation: CreateAccountNavigation
    
    init(navigation: CreateAccountNavigation) {
        self.navigation = navigation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let offset: CGFloat = 10
    
    let emailButton = MainButton()
    let googleButton = MainButton()
    let textView = TextFieldView()
    
    let separateLabel: UILabel = {
        let label = UILabel()
         label.text = "⎯⎯⎯⎯  Or continue with  ⎯⎯⎯⎯"
         label.font = UIFont.boldSystemFont(ofSize: 16)
         label.textColor = .gray
         label.textAlignment = .center
         return label
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        return button
    }()
    
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
        stackView.axis = .vertical
        stackView.spacing = 41
        stackView.alignment = .fill
        stackView.distribution = .fill
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
        
        [screenNameLabel, screenDescriptionLabel, stackView, loginButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        emailButton.setButton(style: .fill, title: "Continue with email")
        emailButton.delegate = self
        let googleIconImage = UIImage(named: "google-symbol")
        googleButton.setButton(style: .borderAndStaticImage, title: "Continue with google", andImage: googleIconImage)
        googleButton.delegate = self
        textView.configure(style: .border, textFildPlaceholder: "example@gmail,com")
        textView.textField.delegate = self
        setAttributeForButton()
        
        loginButton.addTarget(self, action: #selector(logitButtonPressed), for: .touchUpInside)
        
        configureStackView()
    }
    
    func configureStackView() {
        [textView, emailButton, separateLabel, googleButton].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    func setAttributeForButton() {
        let attributedString = NSMutableAttributedString(string: "Already have an account? Login")
        attributedString.addAttributes([.foregroundColor : UIColor.gray,
                                        .font : UIFont.boldSystemFont(ofSize: 16)],
                                       range: NSRange(location: 0, length: 24))
        attributedString.addAttributes([.foregroundColor : UIColor.blue,
                                        .font : UIFont.boldSystemFont(ofSize: 16)],
                                       range: NSRange(location: 25, length: 5))
        loginButton.setAttributedTitle(attributedString, for: .normal)

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
            
            stackView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -20),
            
            separateLabel.heightAnchor.constraint(equalToConstant: 22),
            
            loginButton.heightAnchor.constraint(equalToConstant: 24),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

// MARK: - Navigation
extension CreateAccountViewController: MainButtonDelegate {
    func buttonPressed(button: UIButton) {
        self.navigation.finish()
        if let title = button.currentTitle {
            print(title)
        }
    }
    
    @objc func logitButtonPressed() {
        self.navigation.finish()
    }
}

// MARK: - UITextFieldDelegate
extension CreateAccountViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let test = textField.text {
            print(test)
            textField.resignFirstResponder()
        }
        return true
    }
}

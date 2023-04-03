//
//  RegisterTableViewCell.swift
//  MovieApp
//
//  Created by Artur Imanbaev on 03.04.2023.
//

import UIKit

class RegisterTableViewCell: UITableViewCell {
    var check = false
    let imageField : UIImageView = {
        $0.image = UIImage(named: "textfield")
        $0.contentMode = .scaleToFill
        $0.isUserInteractionEnabled = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    let textField: PasswordTextField = {
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 15)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(PasswordTextField())
    let labelTextInfo: UILabel = {
        $0.textColor = .black
        $0.text = "hello"
        $0.font = .systemFont(ofSize: 15)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    let hidePasswordButton: UIButton = {
        $0.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        $0.tintColor = .lightGray
        $0.isUserInteractionEnabled = true
        $0.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    convenience init(_ nameField: String,_ labelInfo: String){
        self.init()
        self.addCustomView()
        textField.placeholder = "\(nameField)"
        labelTextInfo.text = labelInfo
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func buttonTapped(){
        check = !check
        textField.isSecureTextEntry = check
        textField.clearsOnBeginEditing = false;
    }
    func addCustomView(){
        self.contentView.addSubview(labelTextInfo)
        NSLayoutConstraint.activate([
            labelTextInfo.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            labelTextInfo.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 5)
        ])
        self.contentView.addSubview(imageField)
        NSLayoutConstraint.activate([
            imageField.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 10),
            imageField.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: -15),
            imageField.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: 15),
            imageField.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
        imageField.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: imageField.topAnchor, constant: -25),
            textField.bottomAnchor.constraint(equalTo: imageField.bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: imageField.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: imageField.trailingAnchor)
        ])
        imageField.addSubview(hidePasswordButton)
        NSLayoutConstraint.activate([
            hidePasswordButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            hidePasswordButton.trailingAnchor.constraint(equalTo: imageField.trailingAnchor, constant: -50)
        ])
    }
}
class PasswordTextField: UITextField {

    override var isSecureTextEntry: Bool {
        didSet {
            if isFirstResponder {
                _ = becomeFirstResponder()
            }
        }
    }
    override func becomeFirstResponder() -> Bool {

        let success = super.becomeFirstResponder()
        if isSecureTextEntry, let text = self.text {
            self.text?.removeAll()
            insertText(text)
        }
         return success
    }
}

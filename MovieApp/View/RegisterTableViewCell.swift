//
//  RegisterTableViewCell.swift
//  MovieApp
//
//  Created by Artur Imanbaev on 03.04.2023.
//

import UIKit

class RegisterTableViewCell: UITableViewCell {
    let imageField : UIImageView = {
        $0.image = UIImage(named: "textfield")
        $0.contentMode = .scaleToFill
        $0.isUserInteractionEnabled = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    let textField: UITextField = {
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 20)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextField())
    let labelTextInfo: UILabel = {
        $0.textColor = .black
        $0.text = "hello"
        $0.font = .systemFont(ofSize: 15)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addCustomView()
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
    }
}

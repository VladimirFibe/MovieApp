//
//  TextFieldView.swift
//  MovieApp
//
//  Created by Павел Грицков on 04.04.23.
//

import UIKit

enum ConfigureStyle {
    case fill
    case border
}

class TextFieldView: UIView {
    
    
    private let height: CGFloat = 56.0
    private var width: CGFloat = 300
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 18)
        return textField
    }()
    
    private func configureUI() {
        layer.cornerRadius = height / 2
        addSubview(textField)
        setConstraints()
    }
    
    /// Элемент для интерфейса textField вложеный в контайнер UIView.
    ///  Есть параметры размера по умолчанию с низким приоритетом высота: 56.0 ширина: 300.0
    /// - Parameters:
    ///   - style: стиль элемента fill - залитый цветов border - прозрачный и с рамкой
    ///   - placeholder: ваш placeholder для textField
    func configure(style: ConfigureStyle, textFildPlaceholder: String) {
        configureUI()
        textField.placeholder = textFildPlaceholder
        
        // Тут можно задать параметры своего стиля
        switch style {
        case .fill:
            backgroundColor = Theme.textFieldBack
            // TODO: cgColor - похоже не подерживает смеры всетлой и темной темы
//            layer.borderColor = Theme.textFieldBorder.cgColor
//            layer.borderWidth = 2
        case .border:
            layer.borderColor = UIColor.gray.cgColor
            layer.borderWidth = 2
        }
    }
    
    private func setConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        let widthConstraint = NSLayoutConstraint(
            item: self,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .width,
            multiplier: 1.0,
            constant: width)
        widthConstraint.priority = .defaultLow
        
        let heightConstraint = NSLayoutConstraint(
            item: self,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .width,
            multiplier: 1.0,
            constant: height)
        heightConstraint.priority = .defaultHigh

        NSLayoutConstraint.activate([
            heightConstraint,
            widthConstraint,
            
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.heightAnchor.constraint(equalTo: heightAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20)
        ])
    }
}

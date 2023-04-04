//
//  MainButton.swift
//  MovieApp
//
//  Created by Павел Грицков on 04.04.23.
//

import UIKit

protocol MainButtonDelegate {
    func buttonPressed(button: UIButton)
}

class MainButton: UIButton {
    
    enum ConfigureStyle {
        case fill
        case withoutFill
    }

    var delegate: MainButtonDelegate?
    
    private let height: CGFloat = 56.0
    private var width: CGFloat = 300

    func setButton(style: ConfigureStyle,andTitle title: String) {
        
        setTitle(title, for: .normal)
        
        switch style {
        case .fill:
            backgroundColor = .orange
            setTitleColor(.white, for: .normal)
        case .withoutFill:
            backgroundColor = .none
            setTitleColor(.black, for: .normal)
            self.layer.borderColor = UIColor.black.cgColor
            self.layer.borderWidth = 2
        }
        
        self.layer.cornerRadius = height / 2
        translatesAutoresizingMaskIntoConstraints = false
        
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        setConstraints()
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        delegate?.buttonPressed(button: sender)
    }
    
    // MARK: - Set Constraints
    private func setConstraints() {
        
        let widthConst = NSLayoutConstraint(
            item: self,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .width,
            multiplier: 1.0,
            constant: width)
        widthConst.priority = .defaultLow

        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: height),
            widthConst
        ])
    }
}

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
    
    var delegate: MainButtonDelegate?
    
    enum ConfigureStyle {
        case fill
        case border
        case borderAndImage
        case borderAndStaticImage
    }

    private var imageForButtonCondition: UIImage? {
        if isOn {
            return UIImage(systemName: "checkmark.circle.fill")
        } else {
            return UIImage(systemName: "checkmark.circle")
        }
    }
    
    private var isOn = false
    private var isStaticImage = true
    
    private let height: CGFloat = 56.0
    private var width: CGFloat = 300
    
    func setButton(style: ConfigureStyle,title text: String, andImage image: UIImage? = nil) {
        
        setTitle(text, for: .normal)
        
        let image = image ?? imageForButtonCondition
        
        switch style {
        case .fill:
            backgroundColor = .orange
            setTitleColor(.white, for: .normal)
        case .border:
            backgroundColor = .none
            setTitleColor(.black, for: .normal)
            layer.borderColor = UIColor.gray.cgColor
            layer.borderWidth = 2
        case .borderAndImage:
            isStaticImage = false
            setTitle("  \(text)", for: .normal)
            backgroundColor = .none
            setTitleColor(.black, for: .normal)
            layer.borderColor = UIColor.gray.cgColor
            layer.borderWidth = 2
            setImage(image, for: .normal)
            contentHorizontalAlignment = .left
            contentEdgeInsets = .init(top: 0, left: 18, bottom: 0, right: 0)
        case .borderAndStaticImage:
            setTitle("  \(text)", for: .normal)
            backgroundColor = .none
            setTitleColor(.black, for: .normal)
            layer.borderColor = UIColor.gray.cgColor
            layer.borderWidth = 2
            setImage(image, for: .normal)
            contentHorizontalAlignment = .left
            contentEdgeInsets = .init(top: 0, left: 18, bottom: 0, right: 0)
        }
        
        self.layer.cornerRadius = height / 2
        
        setConstraints()
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        delegate?.buttonPressed(button: sender)
        if !isStaticImage {
            isOn = !isOn
            setImage(imageForButtonCondition, for: .normal)
        }
    }
    
    private func setConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        
        let widthConst = NSLayoutConstraint(
            item: self,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .width,
            multiplier: 1.0,
            constant: width)
        widthConst.priority = .defaultLow
        widthConst.isActive = true
        
        let heightConstraint = NSLayoutConstraint(
            item: self,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .width,
            multiplier: 1.0,
            constant: height)
        heightConstraint.priority = .defaultLow
        heightConstraint.isActive = true
    }
}

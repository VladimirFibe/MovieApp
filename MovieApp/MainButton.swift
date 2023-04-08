//
//  MainButton.swift
//  MovieApp
//
//  Created by Павел Грицков on 04.04.23.
//
import UIKit

protocol MainButtonDelegate: AnyObject {
    func buttonPressed(button: UIButton)
}

class MainButton: UIButton {
    
    weak var delegate: MainButtonDelegate?
    
    enum ConfigureStyle {
        case fill
        case border
        case borderAndImage
        case borderAndStaticImage
    }

    private var turnOnImage: UIImage? {
        return UIImage(systemName: "checkmark.circle.fill")
    }
    
    private var turnOffImage: UIImage? {
        return UIImage(systemName: "circle")
    }
    
    private var isOn = false
    private var isStaticImage = true
    
    private let height: CGFloat = 56.0
    private var width: CGFloat = 300
    
    private let buttonTextColor = Theme.darkGreyToWhite
    
    func setButton(
        style: ConfigureStyle, title text: String,
        image: UIImage? = nil, isActive: Bool? = nil) {
        
        setTitle(text, for: .normal)
        isOn = isActive ?? false
        
        switch style {
        case .fill:
            backgroundColor = Theme.purple
            setTitleColor(.white, for: .normal)
        case .border:
            backgroundColor = .none
            setTitleColor(buttonTextColor, for: .normal)
            layer.borderColor = UIColor.gray.cgColor
            layer.borderWidth = 2
        case .borderAndImage:
            isStaticImage = false
            setTitle("  \(text)", for: .normal)
            backgroundColor = .none
            setTitleColor(buttonTextColor, for: .normal)
            layer.borderColor = UIColor.gray.cgColor
            layer.borderWidth = 2
            switchButton()
            contentHorizontalAlignment = .left
            contentEdgeInsets = .init(top: 0, left: 18, bottom: 0, right: 0)
        case .borderAndStaticImage:
            setTitle("  \(text)", for: .normal)
            backgroundColor = .none
            setTitleColor(buttonTextColor, for: .normal)
            layer.borderColor = UIColor.gray.cgColor
            layer.borderWidth = 2
            setImage(image, for: .normal)
        }
        
        self.layer.cornerRadius = height / 2
        
        setConstraints()
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        delegate?.buttonPressed(button: sender)
        switchButton()
    }
    
    private func switchButton() {
        if !isStaticImage {
            if isOn {
                setImage(turnOnImage, for: .normal)
                tintColor = Theme.purple
                isOn = !isOn
            } else {
                setImage(turnOffImage, for: .normal)
                tintColor = Theme.darkGreyToWhite
                isOn = !isOn
            }
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
        heightConstraint.isActive = true
    }
}

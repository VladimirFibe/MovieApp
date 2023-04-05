//
//  MainButton.swift
//  MovieApp
//
//  Created by Павел Грицков on 04.04.23.
//

import UIKit

class MainButton: UIButton {
    
    enum ConfigureStyle {
        case fill
        case withoutFill
    }
    
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
            self.layer.borderColor = UIColor.gray.cgColor
            self.layer.borderWidth = 2
        }
        
        self.layer.cornerRadius = height / 2
        
        setConstraints()
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

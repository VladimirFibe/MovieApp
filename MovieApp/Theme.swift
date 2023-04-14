//
//  Theme.swift
//  MovieApp
//
//  Created by Марк Райтман on 04.04.2023.
//

import Foundation
import UIKit

enum Theme {
    
    //MARK: - Main colors
    static let purple: UIColor = UIColor(named: "Purple")!
    static let white: UIColor = UIColor(named: "White")!
    static let whiteToBlack: UIColor = UIColor(named: "WhiteToBlack")!///для вьюшек и бэкграунда
    static let purpleToBlack: UIColor = UIColor(named: "PurpleToBlack")!///для бэка SplashVC
    static let lightPurpleToGrey: UIColor = UIColor(named: "LightPurpleToGrey")!///для бэка иконки на SplashVC
    static let lightGreyToPurple: UIColor = UIColor(named: "LightGreyToPurple")!///для свича на SettingVC
    static let starsColor: UIColor = UIColor(named: "StarsColor")!///для рейтинговых звёзд
    static let darkGreyToWhite: UIColor = UIColor(named: "DarkGreyToWhite")!///для иконок в мини-описании (метаданных) к фильму
    /// светлая тема поле TextField
    static let textFieldBack = UIColor(named: "TextFieldBack")
    /// черный и белый
    static let blackToWhite = UIColor(named: "BlackToWhite")
    /// рамка для вью textField в темной теме
    static let textFieldBorder = UIColor(named: "TextFieldBorder")!
    
    //MARK: - Views' style
#warning("здесь поправьте как нужно")
    static let buttonCornerRadius: CGFloat = 15
    static let imageCornerRadius: CGFloat = 20
    
    //MARK: - Layout
#warning("здесь поправьте как нужно")
    static let spacing: CGFloat = 20
    static let leftOffset: CGFloat = 20
    static let topOffset: CGFloat = 10
}

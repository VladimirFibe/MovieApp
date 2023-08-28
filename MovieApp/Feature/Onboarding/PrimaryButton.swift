//
//  PrimaryButton.swift
//  MovieApp
//
//  Created by Vladimir Fibe on 28.08.2023.
//

import UIKit

class PrimaryButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 24
        backgroundColor = AppColor.mainPrimary.uiColor
        heightAnchor.constraint(equalToConstant: 56).isActive = true
        titleLabel?.font = AppFont.semibold.s16()
        tintColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

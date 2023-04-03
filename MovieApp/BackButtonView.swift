//
//  BackButtonView.swift
//  MovieApp
//
//  Created by Artur Imanbaev on 03.04.2023.
//

import UIKit

class BackButtonView: UIView {
    let backImage: UIImageView = {
        $0.image = UIImage(systemName: "arrow.backward.circle")
        $0.isUserInteractionEnabled = true
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    let backButton: UIButton = {
        $0.addTarget(self, action: #selector(pushBack), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    var goBackTapCallBack: () -> () = {}
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 50, height: 50)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc
    private func pushBack(){
        goBackTapCallBack()
    }
    func setupUI(){
        self.addSubview(backImage)
        NSLayoutConstraint.activate([
            backImage.topAnchor.constraint(equalTo: self.topAnchor),
            backImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),

        ])
        backImage.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.centerXAnchor.constraint(equalTo: backImage.centerXAnchor),
            backButton.centerYAnchor.constraint(equalTo: backImage.centerYAnchor),

        ])
        
    }
}

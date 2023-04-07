//
//  ButtonView.swift
//  MovieApp
//
//  Created by Artur Imanbaev on 03.04.2023.
//
import UIKit
class ButtonView: UIButton {
    let labelText: UILabel = {
        $0.font = .systemFont(ofSize: 5)
        $0.textAlignment = .center
        $0.textColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    var tapCallBack: () -> () = {}
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.layer.cornerRadius = 20
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc
    private func buttonTapped(){
        tapCallBack()
    }
    func setupUI(){
        self.addSubview(labelText)
        NSLayoutConstraint.activate([
            labelText.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelText.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        self.backgroundColor = UIColor(hexString: Constants.colorHexString)
    }
}

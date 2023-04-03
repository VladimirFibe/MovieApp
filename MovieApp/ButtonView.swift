//
//  ButtonView.swift
//  MovieApp
//
//  Created by Artur Imanbaev on 03.04.2023.
//

import UIKit

class ButtonView: UIButton {
    let labelText: UILabel = {
        $0.font = .systemFont(ofSize: 14)
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
        self.backgroundColor = colorWithHexString(hexString: "514EB6")
    }
}
//MARK: extension to get color
extension ButtonView{
    func colorWithHexString(hexString: String, alpha:CGFloat = 1.0) -> UIColor {
        
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexStr: hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value
        hexInt = UInt32(bitPattern: scanner.scanInt32(representation: .hexadecimal) ?? 0)
        return hexInt
    }
}

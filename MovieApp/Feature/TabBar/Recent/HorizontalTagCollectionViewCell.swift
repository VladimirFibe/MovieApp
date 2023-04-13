////
////  HorizontalTagCollectionViewCell.swift
////  MovieApp
////
////  Created by Artur Imanbaev on 04.04.2023.
////
//
//import UIKit
//
//class HorizontalTagCollectionViewCell: UICollectionViewCell {
//    let nameCategoryLabel: UILabel = {
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.textAlignment = .center
//        $0.textColor = .darkGray
//        $0.font = UIFont.systemFont(ofSize: 15)
//        return $0
//    }(UILabel())
//    override var isSelected: Bool{
//        didSet{
//            backgroundColor = self.isSelected ? UIColor(hexString: Constants.colorHexString) : .white
//            nameCategoryLabel.textColor = self.isSelected ? .white: .darkGray
//        }
//    }
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupViews()
//        setConstraints()
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    private func setupViews(){
//        backgroundColor = .white
//        layer.cornerRadius = 10
//        layer.borderColor = UIColor.lightGray.cgColor
//        layer.borderWidth = 1
//        addSubview(nameCategoryLabel)
//    }
//    private func setConstraints(){
//        NSLayoutConstraint.activate([
//            nameCategoryLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
//            nameCategoryLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
//        ])
//    }
//}

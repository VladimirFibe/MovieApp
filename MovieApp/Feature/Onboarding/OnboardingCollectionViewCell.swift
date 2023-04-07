//
//  OnboardingCollectionViewCell.swift
//  MovieApp
//
//  Created by Dmitriy Babichev on 04.04.2023.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {

    static let identifier = "OnboardingCollectionViewCell"

    let titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Watch your favorite movie easily"
        title.textColor = .black
        title.numberOfLines = 2
        title.textAlignment = .center
        title.font = .systemFont(ofSize: 24, weight: .semibold)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    let descriptionLabel: UILabel = {
        let subTitle = UILabel()
        subTitle.text = "Semper in cursus magna et eu varius nunc adipiscing. Elementum justo, laoreet id sem."
        subTitle.textColor = .systemGray
        subTitle.numberOfLines = 0
        subTitle.textAlignment = .center
        subTitle.font = .systemFont(ofSize: 14, weight: .light)
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        return subTitle
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    func addSubViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 65),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 85),
        ])
    }

    public func configure(title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
    }
}

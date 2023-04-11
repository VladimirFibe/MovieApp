//
//  SearchTableViewCell.swift
//  MovieApp
//
//  Created by Dmitriy Babichev on 09.04.2023.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    static let identifier = "SearchTableViewCell"

    let posterImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "DriftingHome")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Drifting Home"
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 2
        return label
    }()

    let durationLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.262745098, green: 0.3058823529, blue: 0.3450980392, alpha: 1)
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 1
        label.text = "Duration"
        return label
    }()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.262745098, green: 0.3058823529, blue: 0.3450980392, alpha: 1)
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 1
        label.text = "Date"
        return label
    }()

    let genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.262745098, green: 0.3058823529, blue: 0.3450980392, alpha: 1)
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 1
        label.text = "Genre"
        return label
    }()

    let durationIcon: UIImageView = {
        let image = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 12, weight: .regular, scale: .large)
        image.image = UIImage(systemName: "clock.circle.fill", withConfiguration: config)?
            .withTintColor(UIColor(hexString: "434E58"), renderingMode: .alwaysOriginal)
        return image
    }()

    let dateIcon: UIImageView = {
        let image = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 12, weight: .regular, scale: .large)
        image.image = UIImage(systemName: "calendar.circle.fill", withConfiguration: config)?
            .withTintColor(UIColor(hexString: "434E58"), renderingMode: .alwaysOriginal)
        return image
    }()

    let genreIcon: UIImageView = {
        let image = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 12, weight: .regular, scale: .large)
        image.image = UIImage(systemName: "film.circle.fill", withConfiguration: config)?
            .withTintColor(UIColor(hexString: "434E58"), renderingMode: .alwaysOriginal)
        return image
    }()

    lazy var informationStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 10
        [durationLabel, dateLabel, genreLabel].forEach({ stack.addArrangedSubview($0) })
        return stack
    }()

    lazy var iconsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 10
        [durationIcon, dateIcon, genreIcon].forEach({ stack.addArrangedSubview($0) })
        return stack
    }()

    let favoritesButton: UIButton = {
        let action = UIAction { _ in
            print("Added to favorites!")
        }
        let button = UIButton(type: .system, primaryAction: action)
        let config = UIImage.SymbolConfiguration(pointSize: 19)
        let favImage = UIImage(systemName: "heart")?
            .withTintColor(.systemGray2, renderingMode: .alwaysOriginal)
        button.setImage(favImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    func addSubViews() {
        [posterImage, titleLabel, iconsStackView, informationStackView, favoritesButton].forEach({ contentView.addSubview($0) })
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            posterImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),

            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: posterImage.topAnchor, multiplier: 1),
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: posterImage.trailingAnchor, multiplier: 2),
            titleLabel.trailingAnchor.constraint(equalTo: favoritesButton.leadingAnchor),

            iconsStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            iconsStackView.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 2),

            informationStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: iconsStackView.trailingAnchor, multiplier: 1),
            informationStackView.topAnchor.constraint(equalTo: iconsStackView.topAnchor),

            favoritesButton.topAnchor.constraint(equalTo: posterImage.topAnchor),
            favoritesButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            favoritesButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }

    public func configure(image: String, title: String, duration: String, date: String, genre: String) {
        posterImage.image = UIImage(named: image)
        titleLabel.text = title
        durationLabel.text = duration
        dateLabel.text = date
        genreLabel.text = genre
    }
}

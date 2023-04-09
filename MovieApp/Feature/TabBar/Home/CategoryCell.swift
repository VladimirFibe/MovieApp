import UIKit

final class CategoryCell: UICollectionViewCell {
    static let identifier = "CategoryCell"
    
    private let titleLabel = UILabel().apply {
        $0.textColor = UIColor.menuRedColor?.withAlphaComponent(0.4)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.adjustsFontSizeToFitWidth = true
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.backgroundColor = UIColor.menuRedColor?.withAlphaComponent(0.2)
                titleLabel.textColor = .menuRedColor
                titleLabel.font = .systemFont(ofSize: 13, weight: .bold)
                contentView.layer.borderColor = UIColor.clear.cgColor
            } else {
                contentView.backgroundColor = .clear
                contentView.layer.borderColor = UIColor.menuRedColor?.withAlphaComponent(0.4).cgColor
                titleLabel.textColor = UIColor.menuRedColor?.withAlphaComponent(0.4)
                
                titleLabel.font = .systemFont(ofSize: 13, weight: .regular)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with category: String) {
        titleLabel.text = category
        print(category)
    }
    
    private func setupView() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.menuRedColor?.withAlphaComponent(0.4).cgColor
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = frame.height / 2
    }
}

import UIKit

final class HomeCell: UITableViewCell {
    static let identifier = "HomeCell"
    private let titleImageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    private let categoryLabel = UILabel().apply {
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.textColor = .secondaryLabel
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 3
    }
    
    private let titleLabel = UILabel().apply {
        $0.font = .systemFont(ofSize: 17, weight: .semibold)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 2
    }

    private lazy var stack = UIStackView(arrangedSubviews: [titleImageView, titleLabel]).apply {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.spacing = 12
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(stack)
        layoutViews()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutViews() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 23),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -23),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            titleImageView.widthAnchor.constraint(equalToConstant: 80),
            titleImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func configure(with title: Title) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(title.posterPath)")
        else { return }
        titleImageView.kf.setImage(with: url)
        titleLabel.text = title.originalTitle
    }
}

import UIKit
import Kingfisher

final class HeroHeaderView: UIView {
    
    private let heroImageView = UIImageView().apply {
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        NSLayoutConstraint.activate([
            heroImageView.topAnchor.constraint(equalTo: topAnchor),
            heroImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            heroImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            heroImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        configure(with: "/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with name: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(name)")
        else { return }
        heroImageView.kf.setImage(with: url)
    }
}

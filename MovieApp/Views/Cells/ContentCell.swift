import UIKit
import Kingfisher

protocol ContentCellDelegate: AnyObject  {
    func cellFavouriteButtonDidPress(id: Int)
}

class ContentCell: UITableViewCell {
    
    weak var delegate: ContentCellDelegate?
    // MARK: - Constants
    private let offsetHor: CGFloat = 24.0
    private let offSetVer: CGFloat = 12.0
    var isActiveFavouriteButton = false
    var id: Int?
    // MARK: - Content Views
    let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(named: "DriftingHome")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .lightGray
        return imageView
    }()
    
    let movieNameLabel: UILabel = {
        let label = UILabel()
        label.text = "This is label. This is top label"
        label.textColor = Theme.darkGreyToWhite
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let favouriteButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)
        let image = UIImage(systemName: "heart.fill", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .lightGray
        return button
    }()
    
    let durationMovieView = DescriptionContainerView()
    let dateView = DescriptionContainerView()
    let actionView = DescriptionContainerView()
    
    // MARK: - Containers
    let mainContainer: UIView = {
        let view = UIView()
        return view
    }()

    let favouriteContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    // MARK: - Configure Cell
    func configure(title: String,
                   date: String,
                   duration: String,
                   posterPath: String?,
                   isFavourite: Bool,
                   id: Int? = nil,
                   delegate: ContentCellDelegate? = nil) {
        // TODO: убрать захардкоженые значения
        isActiveFavouriteButton = isFavourite
        movieNameLabel.text = title
        self.id = id
        // загрузка постеров фильмов если они есть если нет устанавливается заглушка
        if let path = posterPath {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(path)")
            movieImageView.kf.setImage(with: url)
        } else {
            movieImageView.image = UIImage(systemName: "photo")
        }
        
        let clockImage = UIImage(systemName: "clock.circle.fill")
        let calendarImage = UIImage(systemName: "calendar.circle.fill")
        let filmImage = UIImage(systemName: "film.circle.fill")
        
        durationMovieView.configure(text: duration, image: clockImage, style: .lable)
        dateView.configure(text: date, image: calendarImage, style: .lable)
        actionView.configure(text: "", image: filmImage, style: .button)
        
        switchButtonFavourite()
        
        setConstraints()
    }
    
    private func switchButtonFavourite() {
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)
        
        if isActiveFavouriteButton {
            let image = UIImage(systemName: "heart.fill", withConfiguration: config)
            favouriteButton.setImage(image, for: .normal)
            favouriteButton.tintColor = Theme.purple
        } else {
            let image = UIImage(systemName: "heart", withConfiguration: config)
            favouriteButton.setImage(image, for: .normal)
            favouriteButton.tintColor = .lightGray
        }
        
        isActiveFavouriteButton = !isActiveFavouriteButton
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        configureUI()
    }

    // MARK: - Setup UI
    func configureUI() {

        [mainContainer, movieImageView, favouriteContainer,
         movieNameLabel, durationMovieView, dateView, actionView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        favouriteContainer.addSubview(favouriteButton)
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        favouriteButton.addTarget(self, action: #selector(favouriteButtonPressed), for: .touchUpInside)
    }
    
    @objc func favouriteButtonPressed(_ sender: UIButton) {
        guard let id = id else { return }
        switchButtonFavourite()
        delegate?.cellFavouriteButtonDidPress(id: id)
    }
    
    // MARK: - Set Constraints
    func setConstraints() {
        NSLayoutConstraint.activate([
            mainContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: offSetVer),
            mainContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: offsetHor),
            mainContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -offsetHor),
            mainContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -offSetVer),
            
            movieImageView.topAnchor.constraint(equalTo: mainContainer.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor),
            movieImageView.widthAnchor.constraint(equalTo: mainContainer.widthAnchor, multiplier: 0.36),
            movieImageView.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor),
            
            favouriteContainer.topAnchor.constraint(equalTo: mainContainer.topAnchor),
            favouriteContainer.widthAnchor.constraint(equalToConstant: offsetHor + (offsetHor / 2)),
            favouriteContainer.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor),
            favouriteContainer.bottomAnchor.constraint(equalTo: mainContainer.bottomAnchor),
            
            movieNameLabel.topAnchor.constraint(equalTo: mainContainer.topAnchor),
            movieNameLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: offsetHor),
            movieNameLabel.trailingAnchor.constraint(equalTo: favouriteContainer.leadingAnchor, constant: -offsetHor),
            movieNameLabel.heightAnchor.constraint(equalToConstant: 24),
            
            durationMovieView.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor),
            durationMovieView.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor),
            durationMovieView.trailingAnchor.constraint(equalTo: favouriteContainer.leadingAnchor),
            
            dateView.topAnchor.constraint(equalTo: durationMovieView.bottomAnchor),
            dateView.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor),
            dateView.trailingAnchor.constraint(equalTo: favouriteContainer.leadingAnchor),
            
            actionView.topAnchor.constraint(equalTo: dateView.bottomAnchor),
            actionView.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor),
            actionView.trailingAnchor.constraint(equalTo: favouriteContainer.leadingAnchor),
            
            favouriteButton.heightAnchor.constraint(equalToConstant: 30),
            favouriteButton.widthAnchor.constraint(equalTo: favouriteButton.heightAnchor),
            favouriteButton.topAnchor.constraint(equalTo: favouriteContainer.topAnchor),
            favouriteButton.trailingAnchor.constraint(equalTo: favouriteContainer.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

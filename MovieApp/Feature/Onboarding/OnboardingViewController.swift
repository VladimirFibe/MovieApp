import UIKit

struct OnboardingNavigation {
    let finish: Callback
}

final class OnboardingViewController: BaseViewController {
    let navigation: OnboardingNavigation
    
    init(navigation: OnboardingNavigation) {
        self.navigation = navigation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.index(before: slides.count) {
                continueButton.setTitle("Start watching", for: .normal)
            } else {
                continueButton.setTitle("Continue", for: .normal)
            }
        }
    }
    
    private let slides: [OnboardingSlide] = [
        OnboardingSlide(title: "Watch your favorite movie easily", description: "Drawings can followed improved out sociable not. Earnestly so do instantly pretended."),
        OnboardingSlide(title: "Enjoy your movies anytime", description: "Cause dried no solid no an small so still widen. Ten weather evident smiling bed against she examine its."),
        OnboardingSlide(title: "Watch on different devices", description: "Fancy she stuff after aware merit small his. Charmed esteems luckily age out.")
    ]

    let popcornImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "woman")
        image.contentMode = .scaleAspectFit
        return image
    }()

    let slideView: UIView = {
        let slide = UIView()
        slide.backgroundColor = .white
        slide.layer.cornerRadius = 16
        return slide
    }()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        return collection
    }()

    let pageControl: UIPageControl = {
        let dots = UIPageControl()
        dots.numberOfPages = 3
        dots.currentPageIndicatorTintColor = #colorLiteral(red: 0.3176470588, green: 0.3058823529, blue: 0.7137254902, alpha: 1)
        dots.pageIndicatorTintColor = .systemGray4
        return dots
    }()

    let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.3176470588, green: 0.3058823529, blue: 0.7137254902, alpha: 1)
        button.layer.cornerRadius = 24
        return button
    }()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.3176470588, green: 0.3058823529, blue: 0.7137254902, alpha: 1)
        addSubviews()
        setConstraints()
        configureCollectionView()
        addTargets()
    }

    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier)
    }

    private func addSubviews() {
        [popcornImageView, slideView, collectionView, pageControl, continueButton].forEach { view in
            self.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            slideView.topAnchor.constraint(equalTo: view.centerYAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: slideView.bottomAnchor, multiplier: 2),
            slideView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            slideView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),

            popcornImageView.bottomAnchor.constraint(equalTo: slideView.topAnchor, constant: 15),
            popcornImageView.centerXAnchor.constraint(equalTo: slideView.centerXAnchor),
            view.safeAreaLayoutGuide.topAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: popcornImageView.topAnchor, multiplier: 4),

            slideView.bottomAnchor.constraint(equalToSystemSpacingBelow: continueButton.bottomAnchor, multiplier: 3),
            continueButton.centerXAnchor.constraint(equalTo: slideView.centerXAnchor),
            continueButton.heightAnchor.constraint(equalToConstant: 56),
            continueButton.widthAnchor.constraint(equalToConstant: 200),

            pageControl.topAnchor.constraint(equalToSystemSpacingBelow: slideView.topAnchor, multiplier: 1),
            pageControl.centerXAnchor.constraint(equalTo: slideView.centerXAnchor),

            collectionView.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 30),
            collectionView.leadingAnchor.constraint(equalTo: slideView.leadingAnchor, constant: 25),
            collectionView.trailingAnchor.constraint(equalTo: slideView.trailingAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -30)
        ])
    }

    private func addTargets() {
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }

    @objc private func continueButtonTapped() {
        if currentPage == slides.index(before: slides.count) {
            navigation.finish()
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        slides.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: OnboardingCollectionViewCell.identifier,
            for: indexPath) as! OnboardingCollectionViewCell
        cell.configure(title: slides[indexPath.row].title, description: slides[indexPath.row].description)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

// MARK: - UIScrollViewDelegate
extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}



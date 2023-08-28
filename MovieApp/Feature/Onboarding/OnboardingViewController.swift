import UIKit

final class OnboardingViewController: BaseViewController {
    let slide: OnboardingSlide

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = slide.title
        label.font = AppFont.semibold.s20()
        label.textColor = .white
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = slide.description
        return label
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = slide.image
        return imageView
    }()

    init(slide: OnboardingSlide) {
        self.slide = slide
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnboardingViewController {
    override func setupViews() {
        view.backgroundColor = AppColor.mainPrimary.uiColor
        [titleLabel].forEach { view.addSubview($0)}
    }

    override func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

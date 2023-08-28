import UIKit

final class OnboardingViewController: BaseViewController {
    let slide: OnboardingSlide

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 16
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = slide.title
        label.font = AppFont.bold.s24()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = slide.description
        label.font = AppFont.regular.s14()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = slide.image
        return imageView
    }()

    private lazy var button: PrimaryButton = {
        let button = PrimaryButton(type: .system)
        button.setTitle("Continue", for: [])
        return button
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
        [containerView, imageView].forEach { view.addSubview($0)}
        [titleLabel, descriptionLabel, button].forEach { containerView.addSubview($0)}
    }

    func configure(_ target: Any?, action: Selector) {
        button.addTarget(target, action: action, for: .primaryActionTriggered)
    }

    override func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(325)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(60)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(titleLabel)
        }

        imageView.snp.makeConstraints {
            $0.leading.trailing.equalTo(containerView)
            $0.bottom.equalTo(containerView.snp.top)
        }

        button.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(28)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
        }
    }
}

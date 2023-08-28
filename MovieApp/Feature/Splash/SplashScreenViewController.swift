import UIKit

struct SplashScreenNavigation {
    let finish: Callback
}

class SplashScreenViewController: BaseViewController {
    let navigation: SplashScreenNavigation
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.splashLogo.uiImage
        return imageView
    }()
    
    private let loadingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.loading.uiImage
        return imageView
    }()
    
    init(navigation: SplashScreenNavigation) {
        self.navigation = navigation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SplashScreenViewController {
    override func setupViews() {
        view.backgroundColor = AppColor.mainPrimary.uiColor
        [imageView, loadingImageView].forEach { view.addSubview($0)}
        loadingAnimation()
    }
    
    private func loadingAnimation() {
        UIView.animate(withDuration: 3) {
            self.loadingImageView.transform = CGAffineTransform.identity.rotated(by: CGFloat(Double.pi))
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.navigation.finish()
        }
    }
    
    override func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        loadingImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(100)
        }
    }
}

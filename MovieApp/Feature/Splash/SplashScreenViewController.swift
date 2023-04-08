
import UIKit

enum SplashScreen {
    static let logotext = "Logo"
    static let mainBlue = "mainBlue"
    static let logoImage = "moviePlayLogo"
}

struct SplashScreenNavigation {
    let finish: Callback
}

class SplashScreenViewController: BaseViewController {
    let navigation: SplashScreenNavigation
    init(navigation: SplashScreenNavigation) {
        self.navigation = navigation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "moviePlayLogo")
        imageView.tintColor = .white
        return imageView
    }()
    
    let logoLabel: UILabel = {
        let label = UILabel()
        label.text = "MovieApp"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30, weight: .heavy)
        return label
    }()
    
    let customActivity: UIImageView = {
        let image = UIImage(named: "LoadingPNG")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    var timer: Timer?

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        setConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startTimer()
        
        let delay: TimeInterval = 2
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.navigation.finish()
        }
    }
    
    // MARK: - Start setup
    func configureUI() {
        view.backgroundColor = UIColor(named: "mainBlue")
        
        [logoImageView, logoLabel, customActivity].forEach { view in
            self.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    // MARK: - Animation
    @objc func animateCustomActivityIndicator() {
        UIView.animate(withDuration: 0.8, delay: 0.0, options: .curveLinear) {
            self.customActivity.transform = self.customActivity.transform.rotated(by: CGFloat(Double.pi))
        } completion: { _ in
            if self.timer != nil {
                self.timer = Timer.scheduledTimer(
                    timeInterval: 0.0, target: self,
                    selector: #selector(self.animateCustomActivityIndicator),
                    userInfo: nil, repeats: false)
            }
        }
    }
    
    // MARK: - Timer methods
    func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(
                timeInterval: 0.0, target: self,
                selector: #selector(animateCustomActivityIndicator),
                userInfo: nil, repeats: false)
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: - Set constraints
    func setConstraints() {
        let center = NSLayoutConstraint(
            item: logoImageView,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: view,
            attribute: .centerY,
            multiplier: 0.8,
            constant: 0)
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 88),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
            center,
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            logoLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 12),
            logoLabel.heightAnchor.constraint(equalToConstant: 48),
            logoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            customActivity.widthAnchor.constraint(equalToConstant: 55),
            customActivity.heightAnchor.constraint(equalTo: customActivity.widthAnchor),
            customActivity.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customActivity.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
        ])
    }
    
    deinit {
        print("deinit")
    }
}

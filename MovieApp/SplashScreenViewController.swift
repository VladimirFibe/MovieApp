
import UIKit

enum SplashScreen {
    static let logotext = "Logo"
    static let mainBlue = "mainBlue"
    static let logoImage = "moviePlayLogo"
}

class SplashScreenViewController: UIViewController {
    
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
    
    let activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.color = .white
        return activity
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        setConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        activity.startAnimating()
        
        let delay: TimeInterval = 2
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.moveToNextVC()
        }
    }
    
    func configureUI() {
        view.backgroundColor = UIColor(named: "mainBlue")
        
        [logoImageView, logoLabel, activity].forEach { view in
            self.view.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func moveToNextVC() {
        activity.stopAnimating()
        let vc = ViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func setConstraints() {

        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 88),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            logoLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 12),
            logoLabel.heightAnchor.constraint(equalToConstant: 48),
            logoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            activity.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activity.widthAnchor.constraint(equalToConstant: 60),
            activity.heightAnchor.constraint(equalToConstant: 60),
            activity.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ])
    }
    
    deinit {
        print("deinit")
    }
}

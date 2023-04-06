import UIKit

class ViewController: UIViewController {
    
    let comeBackButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        button.setTitle("Come Back", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
            
            view.addSubview(comeBackButton)
            comeBackButton.center = view.center
            comeBackButton.addTarget(self, action: #selector(comeBackPressed), for: .touchUpInside)
            
        view.backgroundColor = .systemGray
    }

    @objc func comeBackPressed() {
        dismiss(animated: true)
    }
}


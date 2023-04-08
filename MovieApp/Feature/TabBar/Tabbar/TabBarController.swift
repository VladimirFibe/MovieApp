import UIKit

final class TabBarController: UITabBarController, BaseViewControllerProtocol {
    var onRemoveFromNavigationStack: (() -> Void)?
    
    var onDidDismiss: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

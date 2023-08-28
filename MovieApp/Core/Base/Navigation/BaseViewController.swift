import UIKit

public protocol BaseViewControllerProtocol: UIViewController {
    var onRemoveFromNavigationStack: (() -> Void)? { get set }
    var onDidDismiss: (() -> Void)? { get set }
}

open class BaseViewController: UIViewController, BaseViewControllerProtocol {
    public var onRemoveFromNavigationStack: (() -> Void)?
    public var onDidDismiss: (() -> Void)?
    
    override public func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        if parent == nil {
            onRemoveFromNavigationStack?()
        }
    }
    
    open override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag) { [weak self] in
            completion?()
            self?.onDidDismiss?()
        }
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

@objc extension BaseViewController {
    func setupViews() {}
    func setupConstraints() {}
}

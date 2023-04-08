import Foundation

final class ProfileCoordinator: BaseCoordinator {
    var onFlowDidFinish: Callback?
    override func start() {
        runSettings()
    }
    
    private func runSettings() {
        let controller = makeSettings()
        router.setRootModule(controller)
    }
    
    private func runProfile() {
        let controller = makeProfile()
        router.push(controller)
    }
}

extension ProfileCoordinator {
    private func makeSettings() -> BaseViewControllerProtocol {
        let navigation = SettingsNavigation(profileTapped: { [weak self] in
            self?.runProfile()
        },
        logoutTapped: { [weak self] in
            self?.onFlowDidFinish?()
        })
        return SettingsViewController(navigation: navigation)
    }
    
    private func makeProfile() -> BaseViewControllerProtocol {
        ProfileViewController()
    }
}

import Foundation

final class ProfileCoordinator: BaseCoordinator {
    override func start() {
        runRecent()
    }
    
    private func runRecent() {
        let controller = makeRecent()
        router.setRootModule(controller)
    }
}

extension ProfileCoordinator {
    private func makeRecent() -> ViewController {
        return ViewController()
    }
}

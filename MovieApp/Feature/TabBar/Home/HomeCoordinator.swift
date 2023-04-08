import Foundation

final class HomeCoordinator: BaseCoordinator {
    override func start() {
        runRecent()
    }
    
    private func runRecent() {
        let controller = makeRecent()
        router.setRootModule(controller)
    }
}

extension HomeCoordinator {
    private func makeRecent() -> BaseViewController {
        return BaseViewController()
    }
}

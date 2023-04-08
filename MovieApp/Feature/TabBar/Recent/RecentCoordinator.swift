import Foundation

final class RecentCoordinator: BaseCoordinator {
    override func start() {
        runRecent()
    }
    
    private func runRecent() {
        let controller = makeRecent()
        router.setRootModule(controller)
    }
}

extension RecentCoordinator {
    private func makeRecent() -> ViewController {
        return ViewController()
    }
}

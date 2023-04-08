import Foundation

final class FavoriteCoordinator: BaseCoordinator {
    override func start() {
        runRecent()
    }
    
    private func runRecent() {
        let controller = makeRecent()
        router.setRootModule(controller)
    }
}

extension FavoriteCoordinator {
    private func makeRecent() -> ViewController {
        return ViewController()
    }
}

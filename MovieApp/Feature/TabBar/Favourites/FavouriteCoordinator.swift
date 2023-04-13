import Foundation

final class FavouriteCoordinator: BaseCoordinator {
    override func start() {
        runRecent()
    }
    
    private func runRecent() {
        let controller = makeRecent()
        router.setRootModule(controller)
    }
}

extension FavouriteCoordinator {
    private func makeRecent() -> BaseViewController {
        return FavouriteViewController()
    }
}

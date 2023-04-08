import Foundation

final class SearchCoordinator: BaseCoordinator {
    override func start() {
        runSearch()
    }
    
    private func runSearch() {
        let controller = ViewController()
        router.setRootModule(controller)
    }

}

extension SearchCoordinator {
    private func makeSearch() -> BaseViewController {
        return SettingsViewController()
    }
}

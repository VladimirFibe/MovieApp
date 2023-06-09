import Foundation

final class SearchCoordinator: BaseCoordinator {
    override func start() {
        runSearch()
    }
    
    private func runSearch() {
        let controller = makeSearch()
        router.setRootModule(controller)
    }

}

extension SearchCoordinator {
    private func makeSearch() -> BaseViewControllerProtocol {
        return SearchViewController()
    }
}

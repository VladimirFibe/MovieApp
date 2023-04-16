import Foundation

final class HomeCoordinator: BaseCoordinator {
    override func start() {
        runRecent()
    }
    
    private func runRecent() {
        let controller = makeRecent()
        router.setRootModule(controller)
    }
    
    private func runPreview(_ preview: TitlePreviewViewModel) {
        let controller = makePreview(preview)
        router.push(controller)
    }
}

extension HomeCoordinator {
    private func makeRecent() -> BaseViewController {
        return HomeViewController(navigation: HomeNavigation(didLoadPrivew: { preview in
            self.runPreview(preview)
        }))
    }
    
    private func makePreview(_ preview: TitlePreviewViewModel) -> BaseViewController {
        let controler = TitlePreviewViewController()
        controler.configure(with: preview)
        return controler
    }
}

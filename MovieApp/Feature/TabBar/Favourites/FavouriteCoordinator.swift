import Foundation

final class FavouriteCoordinator: BaseCoordinator {
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

extension FavouriteCoordinator {
    private func makeRecent() -> BaseViewController {
        return FavouriteViewController(navigation: FavouriteNavigation(didLoadPrivew: { preview in
            self.runPreview(preview)
        }))
    }
    
    private func makePreview(_ preview: TitlePreviewViewModel) -> BaseViewController {
        let controler = TitlePreviewViewController()
        controler.configure(with: preview)
        return controler
    }
}

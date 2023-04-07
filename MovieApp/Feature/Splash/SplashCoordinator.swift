import Foundation

final class SplashCoordinator: BaseCoordinator {
    var onFlowDidFinish: Callback?
    override func start() {
        runSplash()
    }
    
    private func runSplash() {
        let controller = makeSplash()
        router.setRootModule(controller)
    }
}

extension SplashCoordinator {
    private func makeSplash() -> BaseViewController {
        let navigation = SplashScreenNavigation(finish: {
            self.onFlowDidFinish?()
        })
        return SplashScreenViewController(navigation: navigation)
    }
}

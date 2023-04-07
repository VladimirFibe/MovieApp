import Foundation

final class OnboardingCoordinator: BaseCoordinator {
    var onFlowDidFinish: Callback?
    override func start() {
        runOnboarding()
    }
    
    private func runOnboarding() {
        let controller = makeOnboarding()
        router.setRootModule(controller)
    }
    
}

extension OnboardingCoordinator {
    private func makeOnboarding() -> BaseViewController {
        return OnboardingViewController()
    }
}

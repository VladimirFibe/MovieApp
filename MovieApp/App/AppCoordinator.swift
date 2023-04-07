import Foundation

typealias Callback = () -> Void

final class AppCoordinator: BaseCoordinator {
    var login = true
    override func start() {
        runSplash()
    }
    
    private func run() {
        runAuth()
    }
    
    private func runMain() {
        let coordinator = MainCoordinator(router: router)
        addDependency(coordinator)
        coordinator.start()
    }
    private func runAuth() {
        let coordinator = AuthCoordinator(router: router)
        addDependency(coordinator)
        coordinator.start()
    }
    private func runOnboarding() {
        let coordinator = OnboardingCoordinator(router: router)
        coordinator.onFlowDidFinish = {
            self.run()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    private func runSplash() {
        let coordinator = SplashCoordinator(router: router)
        coordinator.onFlowDidFinish = {
            self.runOnboarding()
        }
        addDependency(coordinator)
        coordinator.start()
    }
}

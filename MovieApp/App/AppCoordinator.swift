import Foundation

typealias Callback = () -> Void

final class AppCoordinator: BaseCoordinator {
    var login = true
    override func start() {
//        runTabBar()
        runSplash()
    }
    
    private func run() {
        runAuth()
    }
    
    private func runTabBar() {
        let coordinator = TabBarCoordinator(router: router)
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func runAuth() {
        let coordinator = AuthCoordinator(router: router)
        coordinator.onFlowDidFinish = {
            self.runTabBar()
        }
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

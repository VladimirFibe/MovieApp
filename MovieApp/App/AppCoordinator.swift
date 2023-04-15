import Foundation
import Firebase
typealias Callback = () -> Void

final class AppCoordinator: BaseCoordinator {
    var login = true
    override func start() {
        runSplash()
    }
    
    private func run() {
        if Settings.shared.onboarded {
            if Auth.auth().currentUser == nil {
                runAuth()
            } else {
                runTabBar()
            }
        } else {
            Settings.shared.onboarded = true
            runOnboarding()
        }
    }
    
    private func runTabBar() {
        let coordinator = TabBarCoordinator(router: router)
        coordinator.onFlowDidFinish = {
            self.run()
        }
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func runAuth() {
        let coordinator = AuthCoordinator(router: router)
        coordinator.onFlowDidFinish = {
            self.run()
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
            self.run()
        }
        addDependency(coordinator)
        coordinator.start()
    }
}

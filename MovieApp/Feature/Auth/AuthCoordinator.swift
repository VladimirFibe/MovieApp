import Foundation

final class AuthCoordinator: BaseCoordinator {
    var onFlowDidFinish: Callback?

    override func start() {
        runAuth()
    }
    
    private func runAuth() {
        let controller = makeAuth()
        router.setRootModule(controller)
    }
    
    private func runSignUp() {
        let controller = makeSignUp()
        router.push(controller)
    }
}

extension AuthCoordinator {
    private func makeAuth() -> BaseViewControllerProtocol {
        let navigation = CreateAccountNavigation(finish: {
            self.runSignUp()
        }, signup: {
            self.onFlowDidFinish?()
        })
        return CreateAccountViewController(navigation: navigation)
    }
    
    private func makeSignUp() -> BaseViewControllerProtocol {
        return BaseViewController()
    }
}

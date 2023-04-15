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
        let navigation = CreateAccountNavigation(login: {
            self.onFlowDidFinish?()
        }, signup: {
            self.runSignUp()
        })
        return CreateAccountViewController(navigation: navigation)
    }
    
    private func makeSignUp() -> BaseViewControllerProtocol {
        let navigation = SignUpNavigation(login: {
            print("мы в координаторе")
            self.onFlowDidFinish?()
        })
        return SignUpViewController(navigation: navigation)
    }
}

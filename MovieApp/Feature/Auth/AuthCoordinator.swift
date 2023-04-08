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
}

extension AuthCoordinator {
    private func makeAuth() -> BaseViewControllerProtocol {
        let navigation = CreateAccountNavigation(finish: {
            self.onFlowDidFinish?()
            print("auth finish")
        })
        return CreateAccountViewController(navigation: navigation)
    }
}

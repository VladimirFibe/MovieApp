import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        startAppCoordinator()
    }
    
    func startAppCoordinator() {
        let navigationController = UINavigationController()
        let router = RouterImpl(rootController: navigationController)
        let appCoordinator = AppCoordinator(router: router)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        appCoordinator.start()
    }
}


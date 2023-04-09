import UIKit

final class TabBarCoordinator: BaseCoordinator {
    var onFlowDidFinish: Callback?
    override func start() {
        print("start tabbar")
        let tabBar = makeTabBar()
        router.setRootModule(tabBar, hideBar: true)
        
        let modules = [makeSearch(), makeRecent(), makeHome(), makeFavorite(), makeProfile()]
        modules.forEach { coordinator, _ in
            addDependency(coordinator)
            coordinator.start()
        }
        let viewControllers = modules.map { $0.1 }
        tabBar.setViewControllers(viewControllers, animated: false)
        tabBar.selectedIndex = 2
    }
}

extension TabBarCoordinator {
    private func makeTabBar() -> BaseViewControllerProtocol & UITabBarController {
        return TabBarController()
    }
    
    private func tabItem(for type: TabItem) -> UITabBarItem {
        let item = UITabBarItem(
            title: nil,
            image: UIImage(named: type.icon)?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: type.activeIcon)?.withRenderingMode(.alwaysOriginal)
        )
        item.imageInsets = UIEdgeInsets(top: 13, left: 0, bottom: -13, right: 0)
        return item
    }
    
    private func makeSearch() -> (BaseCoordinator, UINavigationController) {
        let navigationController = UINavigationController()
        let coordinator = SearchCoordinator(router: RouterImpl(rootController: navigationController))
        navigationController.tabBarItem = tabItem(for: .search)
        return (coordinator, navigationController)
    }
    
    private func makeRecent() -> (BaseCoordinator, UINavigationController) {
        let navigationController = UINavigationController()
        let coordinator = RecentCoordinator(router: RouterImpl(rootController: navigationController))
        navigationController.tabBarItem = tabItem(for: .recent)
        return (coordinator, navigationController)
    }
    
    private func makeHome() -> (BaseCoordinator, UINavigationController) {
        let navigationController = UINavigationController()
        let coordinator = HomeCoordinator(router: RouterImpl(rootController: navigationController))
        navigationController.tabBarItem = tabItem(for: .home)
        return (coordinator, navigationController)
    }
    
    private func makeFavorite() -> (BaseCoordinator, UINavigationController) {
        let navigationController = UINavigationController()
        let coordinator = FavoriteCoordinator(router: RouterImpl(rootController: navigationController))
        navigationController.tabBarItem = tabItem(for: .favorite)
        return (coordinator, navigationController)
    }
    
    private func makeProfile() -> (BaseCoordinator, UINavigationController) {
        let navigationController = UINavigationController()
        let coordinator = ProfileCoordinator(router: RouterImpl(rootController: navigationController))
        coordinator.onFlowDidFinish = onFlowDidFinish
        navigationController.tabBarItem = tabItem(for: .profile)
        return (coordinator, navigationController)
    }
}

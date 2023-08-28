import UIKit

struct OnboardingNavigation {
    let finish: Callback
}

final class OnboardingContainerController: BaseViewController {
    let navigation: OnboardingNavigation
    let pageViewController: UIPageViewController
    var pages: [UIViewController] = []
    var currentPage: UIViewController
    init(navigation: OnboardingNavigation) {
        self.navigation = navigation
        self.pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        let page1 = OnboardingViewController(
            slide: OnboardingSlide(
                title: "Title1",
                description: "Description",
                image: UIImage(systemName: "bell")))
        let page2 = OnboardingViewController(
            slide: OnboardingSlide(
                title: "Title2",
                description: "Description",
                image: UIImage(systemName: "bell")))
        let page3 = OnboardingViewController(
            slide: OnboardingSlide(
                title: "Title3",
                description: "Description",
                image: UIImage(systemName: "bell")))
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        currentPage = pages[0]
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnboardingContainerController {
    override func setupViews() {
        view.backgroundColor = AppColor.mainPrimary.uiColor
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        pageViewController.dataSource = self
        pageViewController.setViewControllers([currentPage], direction: .forward, animated: false)
    }

    override func setupConstraints() {
        pageViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension OnboardingContainerController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController),
              index > 0
        else { return nil }
        currentPage = pages[index - 1]
        return currentPage
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController),
              index + 1 < pages.count
        else { return nil }
        currentPage = pages[index + 1]
        return currentPage
    }
}

import UIKit

enum MovieSection: Hashable {
    case main
}

struct HomeNavigation {
    let didLoadPrivew: (TitlePreviewViewModel) -> ()
}

final class HomeViewController: BaseViewController {
    private var navigation: HomeNavigation
    private var store = HomeStore()
    var bag = Bag()
    private var categories: [String] = ["all","Action","Adventure","Mystery","Horror","Comedian"]
    private var titles: [Title] = Bundle.main.decode([Title].self, from: "Movies.json", keyDecodingStrategy: .convertFromSnakeCase)
    init(navigation: HomeNavigation) {
        self.navigation = navigation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView = UITableView().apply {
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 100
        $0.register(HomeCell.self, forCellReuseIdentifier: "HomeCell")
        $0.delegate = self
        $0.tableHeaderView = HeroHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 400))
    }
    
    private lazy var dataSource: UITableViewDiffableDataSource<MovieSection, Title> = {
        let dataSource = UITableViewDiffableDataSource<MovieSection, Title>(tableView: tableView) { tableView, indexPath, title in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as? HomeCell else { return UITableViewCell()}
            cell.set(rootView: .init(title: title), parentViewController: self)
            return cell
        }
        return dataSource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        configureInitialDiffableSnapshot()
        setupObservers()
        store.sendAction(.fetch)
    }
    
    private func setupObservers() {
        store
            .events
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .didLoad(let titles):
                    DispatchQueue.main.async {
                        self.titles = titles
                        self.configureInitialDiffableSnapshot()
                    }
                case .didLoadPreview(let preview):
                    self.navigation.didLoadPrivew(preview)
                }
            }.store(in: &bag)
    }
    
    func configureInitialDiffableSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<MovieSection, Title>()
        snapshot.appendSections([.main])
        snapshot.appendItems(titles)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let categoriesView = CategoriesHeaderView(categories: categories)
        //        categoriesView.delegate = self
        //        print(categories)
        return categoriesView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let title = titles[indexPath.item]
        CoreDataMamanager.shared.createTitle(title)
        store.actions.send(.fetchPreview(title))
    }
}

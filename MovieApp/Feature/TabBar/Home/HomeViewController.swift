import UIKit

enum MovieSection: Hashable {
    case main
}
final class HomeViewController: BaseViewController {
    private var categories: [String] = ["all","Action","Adventure","Mystery","Horror","Comedian"]
    private var titles: [Title] = Bundle.main.decode([Title].self, from: "Movies.json")
    private lazy var tableView = UITableView().apply {
        $0.rowHeight = UITableView.automaticDimension
        $0.estimatedRowHeight = 100
        $0.register(HomeCell.self, forCellReuseIdentifier: HomeCell.identifier)
        $0.delegate = self
        $0.tableHeaderView = HeroHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 400))
    }
    private lazy var dataSource: UITableViewDiffableDataSource<MovieSection, Title> = {
        let dataSource = UITableViewDiffableDataSource<MovieSection, Title>(tableView: tableView) { tableView, indexPath, title in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.identifier) as? HomeCell else { return UITableViewCell()}
            cell.configure(with: title)
            return cell
        }
        return dataSource
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        configureInitialDiffableSnapshot()
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
        print(categories)
        return categoriesView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        70
    }

}

import UIKit

enum MovieSection: Hashable {
    case main
}

final class HomeViewController: BaseViewController {
    private var store = HomeStore()
    var bag = Bag()
    private var categories: [String] = ["all","Action","Adventure","Mystery","Horror","Comedian"]
    private var titles: [Title] = Bundle.main.decode([Title].self, from: "Movies.json", keyDecodingStrategy: .convertFromSnakeCase)
    
    #warning("[weak self] in")
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
                }
            }.store(in: &bag)
    }
    
    func configureInitialDiffableSnapshot() {
        print(#function)
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
        #warning("store")
    }
}
/*
 {
     tableView.deselectRow(at: indexPath, animated: true)
     let title = titles[indexPath.item]
     guard let name = title.original_name ?? title.original_title else { return }
     APICaller.shared.getMovie(with: name) {[weak self] result in
         guard let self = self else { return }
         DispatchQueue.main.async {
             switch result {
             case .success(let video):
                 let controller = TitlePreviewViewController()
                 let title = self.titles[indexPath.row]
                 controller.configure(with: TitlePreviewViewModel(title: title, video: video))
                 self.navigationController?.pushViewController(controller, animated: true)
             case .failure(let error): print(error.localizedDescription)
             }
         }
     }
 }
 
 */

import UIKit

struct FavouriteNavigation {
    let didLoadPrivew: (TitlePreviewViewModel) -> ()
}

class FavouriteViewController: BaseViewController {
    private var navigation: FavouriteNavigation
    private var store = FavoriteStore()
    var bag = Bag()
    private let heightRow: CGFloat = 184.0
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    let networkManager = NetworkManager()
    
    var movieArray: [TitleItem] = []
    init(navigation: FavouriteNavigation) {
        self.navigation = navigation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setConstraints()
        setupObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        movieArray = CoreDataMamanager.shared.fetchTitleItems()
        tableView.reloadData()
    }
    
    private func setupObservers() {
        store
            .events
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .didLoadPreview(let preview):
                    self.navigation.didLoadPrivew(preview)
                }
            }.store(in: &bag)
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Favourite"
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ContentCell.self, forCellReuseIdentifier: String(describing: ContentCell.self))
        tableView.rowHeight = heightRow
        
        tableView.separatorStyle = .none
        }
    
    func setConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - TableView Data Source
extension FavouriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ContentCell.self)) as! ContentCell
        
        let item = movieArray[indexPath.row]
        let title = item.originalTitle ?? "без названия"
        let duration = "145 Minutes"
        let date = ""
        let isFavourite = true
        let path = item.posterPath
        
        cell.configure(title: title, date: date, duration: duration, posterPath: path, isFavourite: isFavourite, id: Int(item.id), delegate: self)
        cell.delegate = self
        return cell
    }
}

// MARK: - TableView Delegate
extension FavouriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = movieArray[indexPath.item]
        store.actions.send(.fetchPreview(item))
    }
}

// MARK: - Content Cell Delegate
extension FavouriteViewController: ContentCellDelegate {
    func cellFavouriteButtonDidPress(id: Int) {
        CoreDataMamanager.shared.deletaTitleItme(with: Int64(id))
        movieArray = CoreDataMamanager.shared.fetchTitleItems()
        tableView.reloadData()
    }
}

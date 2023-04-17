import UIKit
final class RecentsViewController: BaseViewController {
    
    private let heightRow: CGFloat = 184.0
    private var categories: [String] = ["all","Action","Adventure","Mystery","Horror","Comedian"]
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    let networkManager = NetworkManager()
    
    var movieArray: [MovieData] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setConstraints()
        networkManager.fetchRequestPopularMovie { movieData in
            DispatchQueue.main.async {
                self.movieArray = movieData
                self.tableView.reloadData()
            }
        }
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Recent Watch"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ContentCell.self, forCellReuseIdentifier: String(describing: ContentCell.self))
        tableView.rowHeight = heightRow
        
        tableView.separatorStyle = .none
    }
    
    func setConstraints(){
        
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
extension RecentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ContentCell.self)) as! ContentCell
        
        let title = movieArray[indexPath.row].originalTitle
        let duration = "145 Minutes"
        let date = movieArray[indexPath.row].releaseDate
        let isFavourite = false
        let path = movieArray[indexPath.row].posterPath
        
        cell.configure(title: title, date: date, duration: duration, posterPath: path, isFavourite: isFavourite)
        cell.delegate = self
        return cell
    }
}

// MARK: - TableView Delegate
extension RecentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let categoriesView = CategoriesHeaderView(categories: categories)
        categoriesView.delegate = self
        return categoriesView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //  TODO: Тут осуществить переход на экран детальной информации
        print("the cell with the index path \(indexPath) is selected")
    }
}

extension RecentsViewController: CategoriesHeaderViewDelegate {
    func scrollToRow(with category: String) {
        // do something
    }
    
    func collectionViewDidSelectItem(_ collectionView: UICollectionView, indexPath: IndexPath) {
        print("caterogy item \(indexPath.row) selected")
    }
}

 // MARK: - Content Cell Delegate
extension RecentsViewController: ContentCellDelegate {
    func cellFavouriteButtonDidPress(id: Int) {
        // TODO: Тут обрабатывать нажатие кнопки избранное
    }
}

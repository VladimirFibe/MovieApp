import UIKit
final class RecentsViewController: BaseViewController {
    
    private let heightRow: CGFloat = 184.0
    private var categories: [String] = ["all","Action","Adventure","Mystery","Horror","Comedian"]
    
    //    let tableView = MovieTableView()
    let tableView = UITableView(frame: .zero, style: .plain)
    //    let horizontalMenuCollectionView = HorizontalTagCollectionView()
    
    var movieArray: [Title] = []
    
    var testArray: [Testeble] = [
        .init(title: "Avatar", date: "12-12-1999", duration: "123 Minutes", isFavourite: true),
        .init(title: "Avatar", date: "12-12-1999", duration: "123 Minutes", isFavourite: false),
        .init(title: "Avatar", date: "12-12-1999", duration: "123 Minutes", isFavourite: true),
        .init(title: "Avatar", date: "12-12-1999", duration: "123 Minutes", isFavourite: false),
        .init(title: "Avatar", date: "12-12-1999", duration: "123 Minutes", isFavourite: true),
    ]
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setConstraints()
        //        horizontalMenuCollectionView.cellDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        fetchRequest()
    }
    
    // MARK: -
    // TODO: Перенесли логику в networkManager
    //    func fetchRequest(page: Int = 1){
    //        var apiCall = "https://api.themoviedb.org/3/discover/movie?api_key=6b8a95b1b6c4eeede348d430f4a88303&page=\(page)"
    //        APICaller.shared.fetchRequest(urlString: apiCall, expecting: TrendingTitleResponse.self) { (movieDetails) in
    //
    //                self.tableView.movieInfos = movieDetails.results
    //
    //                DispatchQueue.main.async {
    //                    self.tableView.reloadData()
    //                }
    //            }
    //    }
    
    func configureUI() {
        navigationItem.title = "Recent Watch"
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ContentCell.self, forCellReuseIdentifier: String(describing: ContentCell.self))
        tableView.rowHeight = heightRow
        
        
        
        
        tableView.separatorStyle = .none
        
        //        view.addSubview(horizontalMenuCollectionView)
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
        return testArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ContentCell.self)) as! ContentCell
        
        let title = testArray[indexPath.row].title
        let duration = testArray[indexPath.row].duration
        let date = testArray[indexPath.row].date
        let isFavourite = testArray[indexPath.row].isFavourite
        
        cell.configure(title: title, date: date, duration: duration, isFavourite: isFavourite)
        //        cell.delegate = self
        return cell
    }
}

// MARK: - TableView Delegate
extension RecentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let categoriesView = CategoriesHeaderView(categories: categories)
//        categoriesView.delegate = self
        return categoriesView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //  TODO: Тут осуществить переход на экран детальной информации
        print("the cell with the index path \(indexPath) is selected")
    }
}

// MARK: - Content Cell Delegate
//extension RecentsViewController: ContentCellDelegate {
//    func cellFavouriteButtonDidPress(cell: ContentCell, button: UIButton) {
//        // TODO: Тут обрабатывать нажатие кнопки издранное
//    }
//}



//extension RecentsViewController: SelectCollectionViewItemProtocol{
//    func selectItem(_ index: IndexPath) {
//        fetchRequest(page: index.item + 1)
//    }
//}

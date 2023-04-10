import UIKit
final class RecentsViewController: BaseViewController {
    let movieTable = MovieTableView()
    let horizontalMenuCollectionView = HorizontalTagCollectionView()
    var movieArray: [Title] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        horizontalMenuCollectionView.cellDelegate = self
        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRequest()
    }
    func fetchRequest(page: Int = 1){
        var apiCall = "https://api.themoviedb.org/3/discover/movie?api_key=6b8a95b1b6c4eeede348d430f4a88303&page=\(page)"
        APICaller.shared.fetchRequest(urlString: apiCall, expecting: TrendingTitleResponse.self) { (movieDetails) in
            
                self.movieTable.movieInfos = movieDetails.results
                DispatchQueue.main.async {
                    self.movieTable.reloadData()
                }
            }
    }
    func setupUI(){
        view.addSubview(movieTable)
        NSLayoutConstraint.activate([
            movieTable.topAnchor.constraint(equalTo: view.topAnchor, constant: 165),
            movieTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            movieTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            view.trailingAnchor.constraint(equalTo: movieTable.trailingAnchor, constant: 25),
        ])
        view.addSubview(horizontalMenuCollectionView)
        NSLayoutConstraint.activate([
            horizontalMenuCollectionView.bottomAnchor.constraint(equalTo: movieTable.topAnchor,constant:-10),
            horizontalMenuCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            horizontalMenuCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            horizontalMenuCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
}
extension RecentsViewController: SelectCollectionViewItemProtocol{
    func selectItem(_ index: IndexPath) {
        fetchRequest(page: index.item + 1)
    }
}
